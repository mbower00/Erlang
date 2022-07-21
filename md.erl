-module(md).
-export([markdown_to_html/1, test_string_short/0, test_string_long/0, seperate_words/1]).

test_string_short() -> 
"p
# h1
# h2
### h3
#### h4
##### h5
###### h6
* li
- li
p".

test_string_long() -> 
"# Cool Heading
## Even Cooler Subheading
This is a paragraph!
### An even smaller Subheading
Another paragraph...
#### It gets smaller! 
These headings can get really small!
##### Super Small
That is small!!!!
###### Ok, now this is just crazy...
Do you need a microscope??
## Here is a list!!!
* Unicycle
- Mouse
* Keyboard
* Mountain
- Index Card
* Mint
Did you like my list?
##### Have a nice day!!!".

markdown_to_html(String) ->
    HtmlList = markdown_to_html_acc(seperate_words(String), [], []),
    HtmlString = combine_words(HtmlList),
    io:format("~n~~HTML FROM MARKDOWN~~~n~s~n~n", [HtmlString]),
    display_tags_and_count(HtmlList),
    display_words_and_count(HtmlList).


display_tags_and_count(HtmlList) when HtmlList == [] ->
    % this will not be called if the program works the way it should
    io:format("FROM: display_tags_and_count/1 ~~NO ITEMS TO ANALYIZE (LIST EMPTY)~~~n~n");
display_tags_and_count(HtmlList) ->
    Tags = lists:filter(fun(String) -> (lists:member(60, String) and not lists:member(47, String)) end, HtmlList), % 60 is "<", 47 is "/"
    TagsSize = lists:sum([1 || _ <- Tags]),
    TagsString = combine_words(Tags),
    io:format("~~HTML ANALYSIS~~~nNumber of HTML elements: ~b~nHTML elements: ~s~n~n", [TagsSize, TagsString]).


display_words_and_count(HtmlList) when HtmlList == [] ->
    % this will not be called if the program works the way it should
    io:format("FROM: display_words_and_count/1 ~~NO ITEMS TO ANALYIZE (LIST EMPTY)~~~n~n");
display_words_and_count(HtmlList) ->
    % this will attempt to display tags and number of tags to the user.
    Words = lists:filter(fun(String) -> (not lists:member(60, String) and not (String == [])) end, HtmlList), % 60 is "<"
    WordsSize = lists:sum([1 || _ <- Words]),
    WordsString = combine_words(Words),
    io:format("~~WORD ANALYSIS~~~nNumber of words: ~b~nWords: ~s~n~n", [WordsSize, WordsString]).


markdown_to_html_acc([H|T], Html, Tags) -> 
    % This is a recursive function that uses a list of words in the markdown language and converts it to a list of the words in HTML
    case Tags of
        [] ->
            Tag = [],
            TagsTail = [];
        _ -> % if Tags is not empty
            % get the head of Tags as Tag and the tail as TagsTail
            [Tag|TagsTail] = Tags
    end,
    case H of
        "#" when Tag == [] ->
            % add the proper tag to the head of the html list and the proper end tag to the head of the Tags list
            markdown_to_html_acc(T, ["<h1>"|Html], ["</h1>"|Tags]);
        "##" when Tag == [] ->
            markdown_to_html_acc(T, ["<h2>"|Html], ["</h2>"|Tags]);
        "###" when Tag == [] ->
            markdown_to_html_acc(T, ["<h3>"|Html], ["</h3>"|Tags]);
        "####" when Tag == [] ->
            markdown_to_html_acc(T, ["<h4>"|Html], ["</h4>"|Tags]);
        "#####" when Tag == [] ->
            markdown_to_html_acc(T, ["<h5>"|Html], ["</h5>"|Tags]);
        "######" when Tag == [] ->
            markdown_to_html_acc(T, ["<h6>"|Html], ["</h6>"|Tags]);
        "*" when Tag == [] ->
            markdown_to_html_acc(T, ["<li>","<ul>"|Html], ["</li>","</ul>"|Tags]);
        "-" when Tag == [] ->
            markdown_to_html_acc(T, ["<li>","<ul>"|Html], ["</li>","</ul>"|Tags]);
        "*" when Tag == "</ul>" ->
            markdown_to_html_acc(T, ["<li>"|Html], ["</li>"|Tags]);
        "-" when Tag == "</ul>" ->
            markdown_to_html_acc(T, ["<li>"|Html], ["</li>"|Tags]);
        "\n" -> 
            % add Tag (the head of Tags) to the head of the html list and the TagsTail as the Tags list
            markdown_to_html_acc(T, [Tag|Html], TagsTail);
        _ when Tag == [] -> 
            % when there is no current tag, make it a <p> tag
            markdown_to_html_acc(T, [H,"<p>"|Html], ["</p>"|Tags]);
        _ when Tag == "</ul>" -> 
            % when there is a </ul> as the Tag, add it to the html list
            markdown_to_html_acc([H|T], [Tag|Html], TagsTail);
        _ ->
            % "default", add the H to the html list
            markdown_to_html_acc(T, [H|Html], Tags)
    end;
markdown_to_html_acc([], Html, [H|T]) ->
    markdown_to_html_acc([], [H|Html], T);
markdown_to_html_acc([], Html, []) ->
    % reverse the html list because we have been adding to the head
    lists:reverse(Html).


combine_words(Words) ->
    combine_words_acc(Words, []).

combine_words_acc([H|T], Result) ->
    % this is a recursive function that uses a list of strings and returns a single string of them combined
    SpaceH = H ++ " ", % add a space to the end of H
    combine_words_acc(T, Result ++ SpaceH); % recur with SpaceH added to Result
combine_words_acc([], Result) ->
    Result.


seperate_words(String) ->
% using seperate_words_acc, this function will seperate words from a string
% by " "'s and "\n"'s. It will include "\n"'s as words.
    seperate_words_acc(String, [], []).


seperate_words_acc([H|T], Word, Seperated) ->
    if
        H == 32 -> 
            % if H is 32 (" "), then recur with a blank list 
            % for Word and with the Word (reversed, because we have 
            % been appending to the head) appended to the head 
            % of the Seperated list. 
            seperate_words_acc(T, [], [lists:reverse(Word)|Seperated]); 
        H == 13 ->
            % treat 13 ("\r") like spaces
            seperate_words_acc(T, [], [lists:reverse(Word)|Seperated]); 
        H == 10, Word == [] -> 
            % if H is 10 ("\n") and Word == [], same as 32 but "\n" (WITHOUT Word) is appended to the head
            seperate_words_acc(T, [], ["\n"|Seperated]);
        H == 10 -> 
            % if H is 10 ("\n"), same as 32 but "\n" is also appended to the head
            seperate_words_acc(T, [], ["\n", lists:reverse(Word)|Seperated]);
        true ->
            % else... recur with H appended to the head of the word. 
            seperate_words_acc(T, [H|Word], Seperated)
    end;
seperate_words_acc([], Word, Seperated) ->
    % if the String is empty, return the reversed Seperated list with 
    % the reversed Word added to it
    lists:reverse([lists:reverse(Word)|Seperated]).
