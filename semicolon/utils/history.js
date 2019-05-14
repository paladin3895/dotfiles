#!/usr/bin/env node


/**
 * Module dependencies.
 */

const _ = require('lodash');
const program = require('commander');
const util = require('util');
const fs = require('fs');
const os = require('os');

let number = 100;
program
    .version('0.1.0')
    .arguments('<value>')
    .option('-h, --help', 'Get help text')
    .action(function (value) {
        number = value;
    })
    .parse(process.argv);

let history = fs.readFileSync('/home/king/.zsh_history');

process.stdout.write(
    _.chain(history.toString())
    .split(os.EOL)
    .map(line => {
        return _.chain(line)
            .split(';')
            .last()
            .replace('\\', ' ')
            .value()
    })
    .uniq()
    .map(cli => ({
        name: cli,
        command: cli,
        copy: true,
    }))
    .thru(JSON.stringify)
    .value()
);
