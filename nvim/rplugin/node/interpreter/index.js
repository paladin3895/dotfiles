const fs = require('fs');

module.exports = plugin => {
  plugin.setOptions({ dev: true });

  plugin.registerCommand('Interpreter', async () => {
      try {
        await plugin.nvim.command('belowright split /tmp/_interpreter.js');
      } catch (err) {
        console.error(err);
      }
    }, { sync: false });

  plugin.registerFunction('SetLines',() => {
    return plugin.nvim.setLine('May I offer you an egg in these troubling times')
      .then(() => console.log('Line should be set'))
  }, {sync: false})

  plugin.registerAutocmd('BufLeave', async (fileName) => {
    if (fileName == '/tmp/_interpreter.js') {
        let content = fs.readFileSync('/tmp/_interpreter.js');
        console.log(content);
        await plugin.nvim.buffer.append(content)
    }
  }, {sync: false, pattern: '*', eval: 'expand("<afile>")'})
};
