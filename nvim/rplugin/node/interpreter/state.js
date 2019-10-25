const _ = require('lodash');

function calcPosIndex(pos) {
    return pos[1] + (1 - 1/pos[2]);
}

module.exports = function state(transition) {
    switch (transition) {
        case 'n -> v':
return (context) => {
    context.startPos = context.prevPos;
    context.endPos = context.currentPos;
    return context;
}
        case 'n -> V':
return (context) => {
    context.startPos = context.prevPos;
    context.endPos = context.currentPos;
    return context;
}
        case 'v -> v':
        case 'v -> V':
        case 'V -> v':
        case 'V -> V':
return (context) => {
    context.endPos = context.currentPos;
    context.lines[context.currentPos[1]] = context.line;

    context.visual = _.chain(context.lines)
        .toPairs()
        .map(([lnum, ltext]) => {
            let vtext = ltext;
            let startPos = context.startPos;
            let endPos = context.endPos;
            // if (calcPosIndex(startPos) > calcPosIndex(endPos)) {
            //     startPos = context.endPos;
            //     endPos = context.startPos;
            // }
            if (lnum == startPos[1]) {
                vtext = ltext.slice(startPos[2])
            }
            if (lnum == endPos[1]) {
                vtext = ltext.slice(0, endPos[2])
            }

            return [lnum, vtext]
        })
        .fromPairs()
        .value();

    return context;
}
        case 'v -> n':
        case 'V -> n':
return (context) => {
    context.startPos = context.currentPos;
    context.endPos = context.currentPos;
    context.lines = {
        [context.currentPos[1]]: context.line,
    }
    return context;
}
        case 'n -> n':
return (context) => {
    context.startPos = context.currentPos;
    context.endPos = context.currentPos;
    context.lines = {
        [context.currentPos[1]]: context.line,
    }
    context.visual = {};
    return context;
}
        default:
return (context) => {
    context.endPos = context.currentPos;
}
    }

    // context.visual = [];
    // for (let i = context.startPos[1]; i <= context.endPos[1]; i++) {
    //     let offsetLeft = i == context.startPos[1] ? context.startPos[1] - 1 : 0;
    //     let offsetRight = i == context.endPos[1] ? context.endPos[1] - 1 : Infinity;

    //     context.visual.push(
    //         context.lines[i].split(offsetLeft, offsetRight)
    //     );
    // }
}
