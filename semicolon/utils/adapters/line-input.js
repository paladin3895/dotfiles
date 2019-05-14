const os = require('os');

function handle(chain) {
    return chain
        .split(os.EOL)
        .filter()
}

module.exports = handle;
