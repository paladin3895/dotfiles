const fs = require('fs');
const os = require('os');
const template = fs.readFileSync(`${__dirname}/../templates/update.sql`);

function handle(chain, _) {
  let key = '<none>';

  return chain
    .map((item) => {
      const fields = _.keys(item);
      const values = _.values(item)
        .map(value => {
          if (_.isArray(value) || _.isObject(value)) {
            return JSON.stringify(value);
          }

          return value;
        });
      const update = _.chain(fields)
        .zip(values)
        .map(([field, value]) => {

          let valueSql = value;

          if (value == "NULL") {
            // do nothing
          } else {
            valueSql = _.isString(value) ? `"${value.replace(/\"/g, '\\"')}"` : value;
          }

          if (field == 'id') {
            key = valueSql;
          }

          return `\`${field}\` = ${valueSql}`;
        })
        .value()

      // console.log(update)
      return _.chain(template)
        .replace('/* update */', update.join(', '))
        .replace('/* condition */', `\`id\` = ${key}`)
        .value()
    })
    .join('')
}

module.exports = handle;
