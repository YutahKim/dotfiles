[index](index)
[Return Home](../index.md)

Given a database of courses with dependencies, write a validation function invoked on each update.
Amazon has a catalog of training courses. Each course has a unique String name and can have have a dependency on previous courses that have to be taken before you can start a course.

An example of a valid catalog might look like this:

"Databases": ["Security", "Logging"]
"Security": ["Logging"]
"Logging": []
Your task is to write a validation function that will be invoked when someone updates the catalog. It must indicate whether the new catalog structure is valid or it contains errors.

Twists
Print all distinct courses, sorted alphabetically.
Given a set of courses one wants to study, print their order so the order is valid (this leads to topological sort).


___


Given a sequence of user logins, find the users who logged only once.
Let's say we are working on a shopping website and we want to analyze non returning users to offer them some promotions to get their attention again.

We know that every user has their unique usernames, so we can track whether they are visiting the website again or not.

For this task we need to implement below methods.

newUserLogin(username): This method will be called every time a user logs in
getOldestOneTimeVisitingUser(): This method will return the username of the oldest customer who has visited the website only once.
Example:

newUserLogin(john);
newUserLogin(jeff);
newUserLogin(jeff);
getOldestOneTimeVisitingUser(); should return john
newUserLogin(chriss);
newUserLogin(john);
newUserLogin(adam);
newUserLogin(sandy);
getOldestOneTimeVisitingUser(); should return chriss




// Given a sequence of user logins, find the users who logged only once.
// Let's say we are working on a shopping website and we want to analyze non
// returning users to offer them some promotions to get their attention again.

// We know that every user has their unique usernames, so we can track whether
// they are visiting the website again or not.

// For this task we need to implement below methods.

// newUserLogin(username): This method will be called every time a user logs in
// getOldestOneTimeVisitingUser(): This method will return the username of the
// oldest customer who has visited the website only once. Example:

// newUserLogin(john);
// newUserLogin(jeff);
// newUserLogin(jeff);
// getOldestOneTimeVisitingUser(); should return john
// newUserLogin(chriss);
// newUserLogin(john);
// newUserLogin(adam);
// newUserLogin(sandy);
// getOldestOneTimeVisitingUser(); should return chriss

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
  struct Node *next;
  char *name;
};

struct Pile {
  struct Node *root;
};

// funtions prototypes
int comp_str(char *str1, char *str2);

void push(struct Node *root, struct Node *new_node) {
  if (root->next == NULL) {
    root->next = (struct Node *)malloc(sizeof(struct Node));
    root->next = new_node;
    new_node->next = NULL;
    printf("\nUser %s added succesfully", new_node->name);
    return;
  } else {
    push(root->next, new_node);
  }
}

int search_duplicate(struct Pile *pile, struct Node *root, struct Node *prev,
                     char *name) {
  if (prev == NULL) {
    printf("\nprev Null");
  } else {
    printf("\nprev %s", prev->name);
  }
  printf("\nSearching for %s, currently on %s", name, root->name);
  if (comp_str(root->name, name) == 1) {
    printf("\n User %s already registered", name);
    if (root->next == NULL) {
      printf("\nUser is on last position so no action needed");
    } else {
      if (prev != NULL) {
        prev->next = (struct Node *)malloc(sizeof(struct Node));
        prev->next = root->next;
      }
      if (prev == NULL) {
        pile->root = root;
      }
      if (root->next != NULL) {
        push(root->next, root);
      }
    }
    return 1;
  } else if (root->next == NULL) {
    printf("User %s not found so, adding it at last", name);
    struct Node *new_node = (struct Node *)malloc(sizeof(struct Node));
    new_node->name = name;
    new_node->next = NULL;
    push(root, new_node);
    return 0;
  }
  if (root->next != NULL) {
    search_duplicate(pile, root->next, root, name);
  }
  return 0;
}

void newUserLogin(struct Pile *pile, char *name) {
  printf("\nAdding a new user %s", name);
  if (pile->root == NULL) {
    pile->root = (struct Node *)malloc(sizeof(struct Node));
    pile->root->name = name;
    pile->root->next = (struct Node *)malloc(sizeof(struct Node));
    pile->root->next = NULL;
  } else {
    int user_already_registered = 0;
    struct Node *foundNode = (struct Node *)malloc(sizeof(struct Node));
    foundNode = NULL;

    user_already_registered =
        search_duplicate(pile, pile->root, foundNode, name);
  }
}

char *getOldestOneTimeVisitingUser(struct Pile *pile) {
  printf("\n------------\n");
  printf("\noldest user %s\n", pile->root->name);
  printf("\n------------\n");
  return pile->root->name;
}

int len(char *str) {
  int i = 0;
  while (*str != '\0') {
    str++;
    i++;
  }
  return i;
}

void print_pile(struct Pile *pile) {
  struct Node *current_node = pile->root;
  if (current_node != NULL) {
    printf("\n----\n");
    printf("\n%s -> \n", current_node->name);
    printf("\n----\n");
  }
  while (current_node->next != NULL) {
    printf("\n----\n");
    printf("\n%s -> \n", current_node->next->name);
    printf("\n----\n");
    current_node = current_node->next;
  }
}
int comp_str(char *str1, char *str2) {
  int len1 = len(str1);
  int len2 = len(str2);
  printf("\n comparing %s with %s\n", str1, str2);
  if (len1 != len2) {
    return 0;
  } else {
    for (int i = 0; i < len1; i++) {
      if (str1[i] != str2[i]) {
        return 0;
      }
    }
  }
  return 1;
}

int testCase(struct Pile *pile) {
  printf("Running test cases");
  int testResult = 0;
  printf("Running test cases");

  newUserLogin(pile, "john");
  print_pile(pile);
  newUserLogin(pile, "jeff");
  print_pile(pile);
  newUserLogin(pile, "jeff");
  print_pile(pile);
  testResult += comp_str(getOldestOneTimeVisitingUser(pile), "john");
  newUserLogin(pile, "chriss");
  print_pile(pile);
  newUserLogin(pile, "john");
  print_pile(pile);
  newUserLogin(pile, "john");
  print_pile(pile);
  newUserLogin(pile, "adam");
  print_pile(pile);
  newUserLogin(pile, "sandy");
  print_pile(pile);
  testResult += comp_str(getOldestOneTimeVisitingUser(pile), "chriss");
  printf("%d test cases passed", testResult);
  return testResult;
}

int main() {
  struct Pile *pile;
  pile = (struct Pile *)malloc(sizeof(struct Pile));
  printf("pile created\n");
  pile->root = NULL;
  printf("root node created\n");
  testCase(pile);

  return 0;
}

___

Design a system that allows users to share files with each other
Let us say I am a amateur film maker and I want to send the video to my friend.

I would like to upload it somewhere and send him a link, but I do not want anybody else to download the file, even if they have the link.

Once the friend says it is good, I would like to share the link with everyone and let them see it too.

Twists
What do we do if the file is bigger than capacity on a single node?
What if one node goes down or a single disk is broken?
How do we balance free space between the nodes?
We can offer free and premium service, each with different storage limits.
We can introduce monthly fees according to the capacity used.


___


Implement file finding utility considering multiple criteria.
Imagine I am a customer and you are implementing an API for me.

My first requirement is to implement an API (or command line utility) that will give me a list of files in the given directory whose name contain the given string.

Design the API and internal objects, including the file system API, if you want to use your own or you do not remember the one in your programming language.

Once this is done, additional criteria will be introduced and I will see how you can deal with change and how extensible your code is.

List<MyFile> find(MyDirectory directory, String str) { /* ... */ }
Twists
matching by file size range, date range, extension and other criteria
matching also directory or files only
recursive flag
