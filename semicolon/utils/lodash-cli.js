#!/usr/bin/env node


/**
 * Module dependencies.
 */

const _ = require('lodash');
const program = require('commander');
const util = require('util');
const fs = require('fs');
const os = require('os');

let expression = '.identity()';

function getInputHandler(context) {
  const { input } = context;

  if (input) {
    const inputHandle = require(`./adapters/${input}-input`);
    return inputHandle;
  }

  return (chain) => chain.thru(JSON.parse);
}

function getOutputHanlder(context) {

  const { output } = context;

  if (output) {
    const inputHandle = require(`./adapters/${output}-output`);
    return inputHandle;
  }

  return (chain) => chain.thru(v => JSON.stringify(v, null, 2));
}

program
  .version('0.1.0')
  .arguments('<expr>')
  .option('-d, --debug', 'Output extra debugging')
  .option('-h, --help', 'Get help text')
  .option('-i, --input <type>', 'Specify input type')
  .option('-c, --config <config>', 'Specify input type')
  .option('-o, --output <type>', 'Specify output type')
  .action(function (expr) {
    expression = expr;
  })
  .parse(process.argv);


process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', (data) => {
  const opts = program.opts();

  try {
    let chain = _.chain(data);
    chain = getInputHandler(program)(chain, _, opts.config);

    chain = eval(`chain${expression}`);

    chain = getOutputHanlder(program)(chain, _, opts.config);

    if (program.debug) {
      console.log(
        _.assign(program.opts(), { expression })
      );
    }

    process.stdout.write(chain.value());

  } catch (e) {
    console.trace(e);

  }

});

