const fs = require('fs');
const os = require('os');
const template = fs.readFileSync(`${__dirname}/../templates/update.sql`);

function handle(chain, _) {
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
          const valueSql = _.isString(value) ? `"${value.replace(/\"/g, '\\"')}"` : value;

          return `\`${field}\` = ${valueSql}`;
        })
        .value()

      // console.log(update)
      return _.chain(template)
        .replace('/* update */', update.join(', '))
        .replace('/* condition */', update.join(', '))
        .value()
    })
    .join('')
}

module.exports = handle;
