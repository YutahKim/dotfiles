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
