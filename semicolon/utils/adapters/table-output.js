/**
 * data description
 * [ { key: value, ... } ]
 *
 */
const fs = require('fs');
const template = fs.readFileSync(`${__dirname}/../templates/datatable.html`);

function handle(chain, _) {
  return chain
    .filter(row => !_.isEmpty(row) && !_.isEqual(row, ['']))
    .reduce((tmp, item) => {

      const fields = _.keys(item);
      const data = _.values(item);

      return {
        fields: _.map(fields, (v) => ({ title: v })),
        data: _.concat(tmp.data, [data]),
      };

    }, {
      data: [],
      fields: [],
    })
    .thru((result) => {
      return _.chain(template)
        .replace('/* data */', JSON.stringify(result.data))
        .replace('/* fields */', JSON.stringify(result.fields))
        .value()
    })
}

module.exports = handle;
