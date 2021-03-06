const _ = require('lodash');
const U = require('urijs')
const M = require('moment');
const V = require('voca');
const XR = require('xregexp');
const fs = require('fs');
const eol = require('eol');
const { plural, singular } = require('pluralize');

_.mixin({
    lines: (val) => {
        return eol.split(val);
    },
    words: (val) => {
        return _.split(val, /[\,\;\s]+/);
    },
    wrap: (val, chars) => {
        const [begin, end] = _.split(chars, '');

        if (_.isArray(val)) {
            return _.map(val, (v) => _.wrap(v, chars));
        }

        return `${begin}${val}${end}`;
    },
    unwrap: (val) => {
        if (_.isArray(val)) {
            return _.map(val, (v) => _.unwrap(v));
        }

        return val.replace(/^\s*(\(|\{|\[|\'|\"|\`)(.*?)(\)|\}|\]|\'|\"|\`)\s*$/, '$2');
    },
    strToArray: (val) => {
        return _.chain(val)
            .words()
            .filter()
            .wrap('""')
            .join(', ')
            .wrap('[]')
            .value();
    },
    plural,
    singular,
})

const scriptPath = '/tmp/_interpreter.js';

module.exports = plugin => {
    plugin.setOptions({dev: true});

    plugin.registerCommand('Semicolon', async () => {
        await plugin.nvim.command(`belowright split ${scriptPath}`);
    }, {sync: false});

    plugin.registerCommand('SemicolonRun', async () => {
        let script = fs.readFileSync(scriptPath).toString();

        try {
            await execute(script, plugin.nvim)
        } catch (err) {
            let escapedError = _.replace(err.message, /"/g, '\\"');
            await plugin.nvim.command(`echom "${escapedError}"`)
        }
    }, {sync: false});

    plugin.registerAutocmd('BufWrite', async (fileName) => {
        if (fileName == scriptPath) {
            let script = fs.readFileSync(scriptPath).toString();
            plugin.nvim._script = script;
            return;
        }

    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    plugin.registerAutocmd('BufEnter', async (fileName) => {
        if (fileName == scriptPath) {
            // fs.writeFileSync(scriptPath, '');
            return;
        }

        if (plugin.nvim._script) {
            try {
                await execute(plugin.nvim._script, plugin.nvim)
            } catch (err) {
                let escapedError = _.replace(err.message, /"/g, '\\"');
                await plugin.nvim.command(`echom "${escapedError}"`)
            }

            plugin.nvim._script = null;
        }
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})
};

async function execute(script, nvim) {
    const {
        mode,
        currentPos, startPos, endPos,
        line, Line, lines,
        word, Word,
        visual, vis,
    } = await getContext(nvim);

    let result;
    result = eval(script);

    if (result.then) {
        result = await result;
    }

    if (_.isArray(result)) {
        result = _.join(result, '\n');
    }

    if (_.get(result, '__chain__')) {
        result = result.value();
    }

    let escapedResult = _.replace(result, /"/g, '\\"');

    return nvim.command(`let @"="${escapedResult}"`)
        .then(() => {
            return nvim.mode;
        })
        .then((modeData) => {
            const mode = _.get(modeData, 'mode');

            if (mode == 'n') {
                return nvim.input(`V""p`);
            }

            if (mode == 'v') {
                return nvim.input(`""p`);
            }

            if (mode == 'V') {
                return nvim.input(`""p`);
            }
        })
}

async function getContext(nvim) {
    const mode = _.get(await nvim.mode, 'mode');
    const visual =  await getVisualContext(nvim);
    const normal =  await getNormalContext(nvim);

    return {
        ...normal, ...visual, mode,
    }
}

async function getNormalContext(nvim) {
    let context = {};
    context.Line = await nvim.getLine();
    context.line = _.trimStart(context.Line);
    context.word = await nvim.commandOutput(`echo expand("<cword>")`);
    context.Word = await nvim.commandOutput(`echo expand("<cWORD>")`);

    context.currentPos = _.split(await nvim.eval(`getpos(".")`), ',').map(_.parseInt);
    return context;
}

async function getVisualContext(nvim) {
    let [startPos, endPos] = await getVisualRange(nvim);
    if (calcPosIndex(startPos) > calcPosIndex(endPos)) {
        [startPos, endPos] = [endPos, startPos];
    }

    let lines = await nvim.buffer.getLines({
        start: startPos[1] - 1,
        end: endPos[1],
        strictIndexing: false,
    });
    let visual = {};

    lines = _.chain(lines)
        .toPairs()
        .map(([lnum, ltext]) => {
            return [startPos[1] + _.parseInt(lnum), ltext];
        })
        .fromPairs()
        .value();

    visual = _.chain(lines)
        .toPairs()
        .map(([lnum, ltext]) => {
            let vtext = ltext;
            if (lnum == startPos[1]) {
                vtext = vtext.slice(startPos[2] - 1)
            }
            if (lnum == endPos[1]) {
                vtext = vtext.slice(0, endPos[2] - startPos[2] + 1)
            }

            return [lnum, vtext]
        })
        .fromPairs()
        .value();

    return {
        startPos,
        endPos,
        lines,
        visual,
        vis: _.chain(visual).values().join('\n').value(),
    }
}

function calcPosIndex(pos) {
    return pos[1] + (1 - 1/pos[2]);
}

function getVisualRange(nvim) {
    let startPos = [];
    let endPos = [];

    return nvim.input('gv')
        .then(() => {
            return Promise.all([
                nvim.eval(`getpos("'<")`),
                nvim.eval(`getpos("'>")`),
            ]);
        })
        .then(([start, end]) => {
            startPos = start;
            endPos = end;

            return [startPos, endPos]
        })
}
