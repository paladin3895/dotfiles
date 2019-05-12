const os = require('os');
const csv2json = require('../libs/csv2json');

function detectDelimiter(input, _) {
  const firstLine = _.chain(input)
    .split(os.EOL)
    .first()
    .value()

  return _.chain([';', ',', "\t"])
    .map((delimiter) => {
      return {
        delimiter,
        count: _.split(firstLine, delimiter).length,
      }
    })
    .maxBy('count')
    .get('delimiter')
    .value()
}

function handle(chain, _, rawConfig) {
  return chain
    .thru(input => {
      const config = eval(`(${rawConfig})`);
      const hasHeader = _.get(config, 'header', true);
      let delimiter = _.get(config, 'delimiter', null);

      switch (delimiter) {
        case '<tab>': delimiter = "\t"; break;
        case '<cr>': delimiter = "\r\n"; break;
        case '<eol>': delimiter = os.EOL; break;
      }

      if (!delimiter) {
        delimiter = detectDelimiter(input, _);
      }

      const csv = csv2json(_.trim(input), delimiter);

      if (!hasHeader) {
        return csv;
      }

      const header = _.first(csv);
      const data = _.slice(csv, 1);

      return _.chain(data)
        .map(row => _.zip(header, row))
        .map(_.fromPairs)
        .value();
    })
    .filter(row => !_.isEqual(row, ['']))
}

module.exports = handle
