const fs = require('fs');
const os = require('os');
const template = fs.readFileSync(`${__dirname}/../templates/upsert.sql`);

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
        })
        .map(value => {
            const valueSql = _.isString(value) ? `"${value.replace(/\"/g, '\\"')}"` : value;
            return valueSql;
        })

      const update = _.chain(fields)
        .zip(values)
        .map(([field, value]) => {

          return `\`${field}\` = ${value}`;
        })
        .value()

      // console.log(update)
      return _.chain(template)
        .replace('/* fields */', fields.join(', '))
        .replace('/* values */', values.join(', '))
        .replace('/* update */', update.join(', '))
        .value()
    })
    .join('')
}

module.exports = handle;
