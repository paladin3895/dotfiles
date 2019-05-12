const csv2json = require('../libs/csv2json');

function handle(chain, _, rawConfig) {
  return chain
    .thru(input => {
      const config = JSON.parse(rawConfig || '{}');
      const hasHeader = _.get(config, 'header', true);
      const delimiter = _.get(config, 'delimiter', ',');

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
