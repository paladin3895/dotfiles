const os = require('os');

function handle(chain) {
  return chain
    .split(os.EOL)
}

module.exports = handle;
