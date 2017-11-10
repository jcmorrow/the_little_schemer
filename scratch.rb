# code
# (a b)
# parser output
# List(a, List(b, ()))
# generator output
# List.new('a', List.new('b', nil))

# code
# (a (b))
# parser output
# List(a, List(List(b, ()), ()))
# generator output
# List.new('a, List.new(List.new('b', nil), nil))
