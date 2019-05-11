def filter(f): map(select(f));

def isempty(f): f == empty;

def isnotempty(f): f != empty;

def sum: reduce .[] as $i (0; . + $i);
