#!/usr/bin/env node

/**
 * Module dependencies.
 */

var program = require('commander');
var V = require('voca');

program
    .version('0.1.0')
    .arguments('<value>')
    .option('-u, --upper-case', 'Change string to upper-case')
    .option('-l, --lower-case', 'Change string to lower-case')
    .option('-t, --title-case', 'Change string to title-case')
    .option('-s, --sentence-case', 'Change string to sentence-case')
    .option('-c, --camel-case', 'Change string to camel-case')
    .option('-k, --snake-case', 'Change string to snake-case')
    .option('--slug-case', 'Change string to slug-case')
    .action(function (value) {
        let result = String(value);
        if (program.upperCase) result = result.toUpperCase();
        if (program.lowerCase) result = result.toLowerCase();
        if (program.titleCase) result = V.titleCase(result);
        if (program.camelCase) result = V.camelCase(result);
        if (program.snakeCase) result = V.snakeCase(result);
        if (program.slugCase) result = V.slugify(result);
        if (program.sentenceCase) result = toSentenceCase(result);

        console.log(result);
    })
    .parse(process.argv);

function toSentenceCase(str) {

    var states = {
        EndOfSentence  : 0,
        EndOfSentenceWS: 1, // in whitespace immediately after end-of-sentence
        Whitespace     : 2,
        Word           : 3
    };

    var state = states.EndOfSentence;
    var start = 0;
    var end   = 0;

    var output = "";
    var word = "";

    function specialCaseWords(word) {
        if( word == "i" ) return "I";
        return word;
    }

    for(var i = 0; i < str.length; i++) {

        var c = str.charAt(i);

        switch( state ) {
            case states.EndOfSentence:

                if( /\s/.test( c ) ) { // if char is whitespace

                    output += " "; // append a single space character
                    state = states.EndOfSentenceWS;
                }
                else {
                    word += c.toLocaleUpperCase();
                    state = states.Word;
                }

                break;

            case states.EndOfSentenceWS:

                if( !( /\s/.test( c ) ) ) { // if char is NOT whitespace

                    word += c.toLocaleUpperCase();
                    state = states.Word;
                }

                break;
            case states.Whitespace:

                if( !( /\s/.test( c ) ) ) { // if char is NOT whitespace

                    output += " "; // add a single whitespace character at the end of the current whitespace region only if there is non-whitespace text after.
                    word += c.toLocaleLowerCase();
                    state = states.Word;
                }

                break;

            case states.Word:

                if( ['.', '?', '!', ':'].indexOf(c) >= 0 ) {

                    word = specialCaseWords( word );
                    output += word;
                    output += c;
                    word = "";
                    state = states.EndOfSentence;

                } else if( !( /\s/.test( c ) ) ) { // if char is NOT whitespace

                    // TODO: See if `c` is punctuation, and if so, call specialCaseWords(word) and then add the puncutation

                    word += c.toLocaleLowerCase();
                }
                else {
                    // char IS whitespace (e.g. at-end-of-word):

                    // look at the word we just reconstituted and see if it needs any special rules
                    word = specialCaseWords( word );
                    output += word;
                    word = "";

                    state = states.Whitespace;
                }

                break;
        }//switch
    }//for

    output += word;

    return output;
}
