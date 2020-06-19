#!/usr/bin/env node


/**
 * Module dependencies.
 */

const _ = require('lodash');
const program = require('commander');
const util = require('util');
const fs = require('fs');
const os = require('os');

program
    .version('0.1.0')
    .arguments('<expr>')
    .option('-d, --debug', 'Output extra debugging')
    .option('-h, --help', 'Get help text')
    .option('-f, --format <type>', 'Specify input type')
    .option('-c, --config <config>', 'Specify input type')
    .option('-o, --output <file>', 'Output result to a file')
    .action(function (expr) {
        expression = expr;
        console.log(expr)
    })
    .parse(process.argv);

// process.stdin.resume();
// process.stdin.setEncoding('utf8');
// process.stdin.on('data', (data) => {
//     const opts = program.opts();

//     // console.log(123);
//     // process.stdout.write(chain.value());
// });

