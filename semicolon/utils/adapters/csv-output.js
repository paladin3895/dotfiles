const json2csv = require('json2csv');

function handle(chain, _) {
  return chain
    .map(item => {
      if (!_.isArray(item)) {
        return [item];
      }

      return item;
    })
    .filter(item => !_.isEmpty(item) && !_.isEqual(item, ['']))
    .thru(data => {
      return json2csv.parse(data);
    })
}

module.exports = handle;
