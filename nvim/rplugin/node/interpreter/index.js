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

    plugin.registerAutocmd('BufEnter', async (fileName) => {
        if (plugin.nvim._output) {
            debugger;
            let output = plugin.nvim._output;
            plugin.nvim._output = null;

            try {
                await Promise.all(_.chain(output)
                    .lines()
                    .map(async (line) => {
                        await plugin.nvim.buffer.append(line);
                    })
                )
            } catch (err) {
                console.error(err);
            }
        }

    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    plugin.registerAutocmd('CursorMoved', async (fileName) => {
        if (fileName == '/tmp/_interpreter.js') {

        } else {
            let context = plugin.nvim._context || {};
            context.mode = await plugin.nvim.mode;
            context.line = await plugin.nvim.getLine();
            context.word = await plugin.nvim.commandOutput(`echo expand("<cword>")`);
            context.Word = await plugin.nvim.commandOutput(`echo expand("<cWORD>")`);

            context.currentPos = _.split(await plugin.nvim.eval(`getpos(".")`), ',');
            context.startPos = _.split(await plugin.nvim.eval(`getpos("'<")`), ',');
            context.endPos = _.split(await plugin.nvim.eval(`getpos("'>")`), ',');

            context.lines = context.lines || {};
            if (['v', 'V'].indexOf(context.mode.mode) >= 0) {
                context.lines[context.currentPos[1]] = context.line;
            } else {
                context.lines = {
                    [context.currentPos[1]]: context.line,
                }
            }
            // context.visual = [];
            // for (let i = context.startPos[1]; i <= context.endPos[1]; i++) {
            //     let offsetLeft = i == context.startPos[1] ? context.startPos[1] - 1 : 0;
            //     let offsetRight = i == context.endPos[1] ? context.endPos[1] - 1 : Infinity;

            //     context.visual.push(
            //         context.lines[i].split(offsetLeft, offsetRight)
            //     );
            // }

            console.log(context.startPos, context.endPos);
            context.prevMode = context.mode;
            plugin.nvim._context = context;
        }
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    plugin.registerAutocmd('BufLeave', async (fileName) => {
        if (fileName == '/tmp/_interpreter.js') {

        } else {
            let context = plugin.nvim._context || {};
            context.mode = await plugin.nvim.mode;
            context.line = await plugin.nvim.getLine();
            context.word = await plugin.nvim.commandOutput(`echo expand("<cword>")`);
            context.Word = await plugin.nvim.commandOutput(`echo expand("<cWORD>")`);

            context.currentPos = _.split(await plugin.nvim.eval(`getpos(".")`), ',');
            context.startPos = _.split(await plugin.nvim.eval(`getpos("'<")`), ',');
            context.endPos = _.split(await plugin.nvim.eval(`getpos("'>")`), ',');

            context.lines = context.lines || {};
            if (['v', 'V'].indexOf(context.mode.mode) >= 0) {
                context.lines[context.currentPos[1]] = context.line;
            } else {
                context.lines = {
                    [context.currentPos[1]]: context.line,
                }
            }
            // context.visual = [];
            // for (let i = context.startPos[1]; i <= context.endPos[1]; i++) {
            //     let offsetLeft = i == context.startPos[1] ? context.startPos[1] - 1 : 0;
            //     let offsetRight = i == context.endPos[1] ? context.endPos[1] - 1 : Infinity;

            //     context.visual.push(
            //         context.lines[i].split(offsetLeft, offsetRight)
            //     );
            // }

            console.log(context.startPos, context.endPos);
            context.prevMode = context.mode;
            plugin.nvim._context = context;
        }
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})

    plugin.registerAutocmd('BufLeave', async (fileName) => {
        if (fileName == '/tmp/_interpreter.js') {
            let content = fs.readFileSync('/tmp/_interpreter.js').toString();
            plugin.nvim._output = content;
        }
    }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})
};
