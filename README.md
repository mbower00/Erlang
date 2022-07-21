# Overview

## Purpose

My purpose was also to gain practice with and learn about the Erlang language. 
My purpose in writing this software was to make Markdown to HTML converter. 

## Project Description

This this project is a converter of Markdown to HTML. It is not a perfect converter between Markdown and HTML (for example, "`* `" and "`- `" do not make separate unordered lists when used with one another), and it does not have all the features of Markdown. It has handling for:
* Paragraphs
* Unordered Lists
* Headings

## Video Demonstration

Here is a demonstration of my software:

[Software Demo Video](https://www.youtube.com/watch?v=b5Ck7CIU20U)

# Development Environment

Visual Studio Code - Very useful for writing code. Here are **some** of the extensions I used...
* Erlang
* Live Server
* etc...

I used the Erlang language for this code. Here are libraries that I used: 
* io - used for printing the screen
* lists - used for some functions involving lists
You could also say that I use the HTML and Markdown languages because my program is a (incomplete) Markdown to HTML converter.

# Useful Websites

* [erlang](https://www.erlang.org/downloads)
* [visualstudio | marketplace](https://marketplace.visualstudio.com/items?itemName=pgourlain.erlang)
* [github | byui-cse](https://github.com/byui-cse/cse121e-course)
* [stackoverflow](https://stackoverflow.com/questions/42080005/erlang-not-working-with-internal-terminal-in-visual-studio-code)
* [oreilly](https://learning.oreilly.com/library/view/programming-erlang-2nd/9781941222454/f_0000.html)
* [wikipedia](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)
* [youtube](https://www.youtube.com/watch?v=SCANNlUpAf4&t=46s)
* [youtube](https://www.youtube.com/watch?v=uhsIu-zP7Hs)
* [tutorialspoint | erlang | erlang_atoms](https://www.tutorialspoint.com/erlang/erlang_atoms.htm)
* [tutorialspoint | erlang | erlang_operators](https://www.tutorialspoint.com/erlang/erlang_operators.htm#)
* [erlang | lists](https://www.erlang.org/doc/man/lists.html)
* [erlang | shell](https://www.erlang.org/doc/man/shell.html)
* [erlang | io](https://www.erlang.org/doc/man/io.html)
* [markdownguide](https://www.markdownguide.org/cheat-sheet/)
* [stackoverflow](https://stackoverflow.com/questions/40343580/displaying-long-lists-in-the-erlang-shell)
* [programming-idioms](https://programming-idioms.org/idiom/12/check-if-list-contains-a-value/1064/erlang)
* [wikipedia](https://en.wikipedia.org/wiki/Erlang_(programming_language))

# Future Work

* Make the markdown_to_html actually return the html
* Make "`* `" and "`- `" make separate unordered lists when used with one another
* Add handling for more markdown functionality
* Look into adding user input
    * When markdown_to_html is called without a string, have it ask for a string from the user.