#!/usr/bin/env node


/**
 * Module dependencies.
 */

const _ = require('lodash');
const program = require('commander');
const util = require('util');
const fs = require('fs');
const os = require('os');
const json2csv = require('json2csv');
const csv2json = require('./csv2json');

let expression = '.identity()';

function getInputHandler(context) {
  if (_.startsWith('grid', context.input)) {
    return `
      .split(os.EOL)
      .tap(console.log)
      .map(line => {
        return _.chain(line)
          .replace(/\\s+/, ' ')
          .trim()
          .split(' ')
          .value()
      })
    `
  }

  if (_.startsWith('line', context.input)) {
    return `
      .split(os.EOL)
      .filter()
    `
  }

  if (_.startsWith('csv', context.input)) {
    return `
      .thru(data => {
        return csv2json(data, ',');
      })
      .filter(row => !_.isEqual(row, ['']))
    `
  }

  return '.thru(JSON.parse)';
}

function getOutputHanlder(context) {

  if (_.startsWith('line', context.output)) {
    return `
      .join(os.EOL)
    `
  }

  if (_.startsWith('csv', context.output)) {
    return `
      .map(item => {
        if (!_.isArray(item)) {
          return [item];
        }

        return item;
      })
      .thru(data => {
        return json2csv.parse(data);
      })
    `
  }

  return `
    .thru(v => JSON.stringify(v, null, 2))
  `
}

program
  .version('0.1.0')
  .arguments('<expr>')
  .option('-d, --debug', 'Output extra debugging')
  .option('-h, --help', 'Get help text')
  .option('-i, --input <type>', 'Specify input type')
  .option('-o, --output <type>', 'Specify output type')
  .action(function (expr) {
    expression = expr;
  })
  .parse(process.argv);


process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', (data) => {
  try {
    const sequences = `
      _.chain(data)
        ${getInputHandler(program)}
        ${expression}
        ${getOutputHanlder(program)}
        .value()
    `
    if (program.debug) {
      console.log(
        _.assign(program.opts(), { expression })
      );
    }

    const result = eval(sequences);
    console.log(result)
  } catch (e) {
    console.trace(e)
  }
});

