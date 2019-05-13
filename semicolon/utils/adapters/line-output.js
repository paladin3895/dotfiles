const os = require('os');

function handle(chain, _) {
  return chain
    .thru(data => _.isArray(data) ? data : [data])
    .join(os.EOL)
}

module.exports = handle;
