const _ = require('lodash');
const fs = require('fs');
const eol = require('eol');

_.mixin({
    lines: (val) => {
        return eol.split(val);
    },
    words: (val) => {
        return _.split(val, /[\s]+/);
    },
})

module.exports = plugin => {
    plugin.setOptions({dev: true});

    plugin.registerCommand('Interpreter', async () => {
        try {
            await plugin.nvim.command('belowright split /tmp/_interpreter.js');
        } catch (err) {
            console.error(err);
        }
    }, {sync: false});

    plugin.registerAutocmd('CursorMoved', async (fileName) => {
        if (fileName == '/tmp/_interpreter.js') {
            return;
        }

        await updateContext(plugin.nvim);
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    // plugin.registerAutocmd('CursorHold', async (fileName) => {
    //     if (fileName == '/tmp/_interpreter.js') {
    //         return;
    //     }

    //     await updateContext(plugin.nvim);
    // }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    // plugin.registerAutocmd('BufEnter', async (fileName) => {
    //     if (fileName == '/tmp/_interpreter.js') {
    //         return;
    //     }

    //     // let context = await updateContext(plugin.nvim);
    // }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    // plugin.registerAutocmd('BufLeave', async (fileName) => {
    //     if (fileName == '/tmp/_interpreter.js') {
    //         let content = fs.readFileSync('/tmp/_interpreter.js').toString();
    //         plugin.nvim._output = content;
    //         return;
    //     }

    //     clearInterval(plugin.nvim._interval);
    // }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})
};

async function updateContext(nvim) {
    let context = nvim._context || {
        mode: 'n',
        tmpMode: 'n',
        prevMode: 'n',
    };

    context.mode = _.get(await nvim.mode, 'mode');
    context.modeChanged = false;

    context.lines = context.lines || {};
    context.visual = context.visual || {};
    context.Line = await nvim.getLine();
    context.line = _.trimStart(context.Line);
    context.word = await nvim.commandOutput(`echo expand("<cword>")`);
    context.Word = await nvim.commandOutput(`echo expand("<cWORD>")`);

    context.prevPos = context.currentPos;
    context.currentPos = _.split(await nvim.eval(`getpos(".")`), ',').map(_.parseInt);
    context.startPos = context.startPos || context.currentPos;
    context.endPos = context.endPos || context.currentPos;

    const transition = `${context.tmpMode} -> ${context.mode}`;
    if (context.tmpMode != context.mode) {
        context.prevMode = context.tmpMode;
        context.tmpMode = context.mode;
        context.modeChanged = true;
    }

    context = state(nvim, transition) ? await state(nvim, transition)(context) : await state(nvim, '*')(context);

    if (context.startPos[1] > context.endPos[1]) {
        let tmp = context.endPos;
        context.endPos = context.startPos;
        context.startPos = tmp;
    }
    const lines = await nvim.buffer.getLines({
        start: context.startPos[1] - 1,
        end: context.endPos[1],
        strictIndexing: false,
    });
    context.lines = _.chain(lines)
        .toPairs()
        .map(([lnum, ltext]) => {
            let startPos = context.startPos;
            return [startPos[1] + _.parseInt(lnum), ltext];
        })
        .fromPairs()
        .value();

    context.visual = _.chain(context.lines)
        .toPairs()
        .map(([lnum, ltext]) => {
            let vtext = ltext;
            let startPos = context.startPos;
            let endPos = context.endPos;
            // if (calcPosIndex(startPos) > calcPosIndex(endPos)) {
            //     startPos = context.endPos;
            //     endPos = context.startPos;
            // }
            if (lnum == startPos[1]) {
                vtext = ltext.slice(startPos[2])
            }
            if (lnum == endPos[1]) {
                vtext = ltext.slice(0, endPos[2])
            }

            return [lnum, vtext]
        })
        .fromPairs()
        .value();

    console.log(context.visual);
    return context;
}

// state module
function calcPosIndex(pos) {
    return pos[1] + (1 - 1/pos[2]);
}

function getVisualRange(nvim, context) {
    let startPos = context.startPos;
    let endPos = context.endPos;

    return nvim.input('o')
        .then(() => {
            return nvim.eval('getpos(".")');
        })
        .then((pos) => {
            startPos = pos;
            return nvim.input('o')
        })
        .then(() => {
            return nvim.eval('getpos(".")');
        })
        .then((pos) => {
            endPos = pos;
            return [startPos, endPos]
        })
}

function state(nvim, transition) {
    switch (transition) {
        case 'n -> v':
return async (context) => {
    let visualRange = await getVisualRange(nvim, context);
    context.startPos = visualRange[0];
    context.endPos = visualRange[1];
    return context;
}
        case 'n -> V':
return async (context) => {
    context.endPos = context.currentPos;
    return context;
}
        case 'v -> v':
return async (context) => {
    context.endPos = context.currentPos;
    return context;
}
        case 'v -> V':
        case 'V -> v':
        case 'V -> V':
return async (context) => {
    context.endPos = context.currentPos;
    return context;
}
        case 'v -> n':
        case 'V -> n':
return async (context) => {
    context.startPos = context.currentPos;
    context.endPos = context.currentPos;
    return context;
}
        case 'n -> n':
return async (context) => {
    context.startPos = context.currentPos;
    context.endPos = context.currentPos;
    return context;
}
        default:
return async (context) => {
    context.endPos = context.currentPos;
}
    }
}
