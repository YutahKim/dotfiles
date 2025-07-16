Example of opening a file for reading:
Python

```Python

try:
    with open('example.txt', 'r') as file:
        content = file.read()
        print(content)
except FileNotFoundError:
    print("The file 'example.txt' was not found.")

```

Example of opening a file for writing:

```Python

with open('new_file.txt', 'w') as file:
    file.write("This is some text written to a new file.")
```

Python sets support various operations for manipulating and comparing sets, analogous to mathematical set theory.
Common Set Operations:
Union: Combines all unique elements from two or more sets.
Operator: |
Method: set1.union(set2)

```Python

    set1 = {1, 2, 3}
    set2 = {3, 4, 5}
    union_set = set1 | set2  # Result: {1, 2, 3, 4, 5}
    union_method = set1.union(set2) # Result: {1, 2, 3, 4, 5}
```

Intersection: Returns a new set containing only the common elements found in both sets.
Operator: &
Method: set1.intersection(set2)

```Python

    set1 = {1, 2, 3}
    set2 = {3, 4, 5}
    intersection_set = set1 & set2  # Result: {3}
    intersection_method = set1.intersection(set2) # Result: {3}
```

Difference: Returns a new set containing elements present in the first set but not in the second.
Operator: -
Method: set1.difference(set2)

```Python

    set1 = {1, 2, 3}
    set2 = {3, 4, 5}
    difference_set = set1 - set2  # Result: {1, 2}
    difference_method = set1.difference(set2) # Result: {1, 2}
```

Symmetric Difference: Returns a new set containing elements that are unique to each set (i.e., in either set but not in their intersection).
Operator: ^
Method: set1.symmetric_difference(set2)

```Python

    set1 = {1, 2, 3}
    set2 = {3, 4, 5}
    symmetric_difference_set = set1 ^ set2  # Result: {1, 2, 4, 5}
    symmetric_difference_method = set1.symmetric_difference(set2) # Result: {1, 2, 4, 5}
```

### Other Useful Set Methods:

add(element): Adds a single element to the set.
update(iterable): Adds multiple elements from an iterable (e.g., list, tuple, another set) to the set.
remove(element): Removes a specified element from the set; raises a KeyError if the element is not found.
discard(element): Removes a specified element from the set; does nothing if the element is not found (no error).
pop(): Removes and returns an arbitrary element from the set.
clear(): Removes all elements from the set.
issubset(other_set): Returns True if all elements of the current set are present in other_set.
issuperset(other_set): Returns True if the current set contains all elements of other_set.
isdisjoint(other_set): Returns True if the two sets have no common elements.
