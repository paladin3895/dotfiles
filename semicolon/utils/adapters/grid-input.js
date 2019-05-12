const os = require('os');

function handle(chain, _) {
  return chain
    .split(os.EOL)
    .map(line => {
      return _.chain(line)
        .replace(/\s+/g, ' ')
        .trim()
        .split(' ')
        .value()
    })
}

module.exports = handle;
