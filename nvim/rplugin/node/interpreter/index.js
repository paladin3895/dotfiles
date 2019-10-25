const _ = require('lodash');
const fs = require('fs');
const eol = require('eol');
const state = require('./state');

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

        plugin.nvim._context;
        await updateContext(plugin.nvim);
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    plugin.registerAutocmd('CursorHold', async (fileName) => {
        if (fileName == '/tmp/_interpreter.js') {
            return;
        }

        // await updateContext(plugin.nvim);
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    plugin.registerAutocmd('BufEnter', async (fileName) => {
        if (fileName == '/tmp/_interpreter.js') {
            return;
        }

        // plugin.nvim._interval = setInterval(async () => {
        //     await updateContext(plugin.nvim);
        // }, 1000)
        // await updateContext(plugin.nvim);
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    plugin.registerAutocmd('BufLeave', async (fileName) => {
        if (fileName == '/tmp/_interpreter.js') {
            let content = fs.readFileSync('/tmp/_interpreter.js').toString();
            plugin.nvim._output = content;
            return;
        }

        clearInterval(plugin.nvim._interval);
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})
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
    context.quote = await getWrappedContent(nvim, "''");
    context.dquote = await getWrappedContent(nvim, '""');
    context.paren = await getWrappedContent(nvim, '()');

    if (context.tmpMode != context.mode) {
        context.prevMode = context.tmpMode;
        context.tmpMode = context.mode;
        context.modeChanged = true;
    }

    const transition = `${context.tmpMode} -> ${context.mode}`;
    context = state(transition) ? state(transition)(context) : state('*')(context);

    nvim._context = context;
}

async function getWrappedContent(nvim, wrap) {
    let [begin, end] = wrap.split('');
    // await nvim.command(`normal vi${begin}"9y\`\``);
}
