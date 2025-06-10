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
