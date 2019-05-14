const fs = require('fs');
const os = require('os');
const template = fs.readFileSync(`${__dirname}/../templates/insert.sql`);

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

            // console.log(values)
            return _.chain(template)
                .replace('/* values */', values.join(', '))
                .replace('/* fields */', fields.join(', '))
                .value()
        })
        .join('')
}

module.exports = handle;
