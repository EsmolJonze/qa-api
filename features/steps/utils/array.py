def find(predicate, collection):
    return next(filter(predicate, collection), None)
