function loadExt(_) {
    return _.mixin({
        eval: eval,
    })
}

module.exports = loadExt;
