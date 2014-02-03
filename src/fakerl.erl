%%%-------------------------------------------------------------------
%%% @author Mawuli Adzaku <mawuli@mawuli.me>
%%% @copyright (C) 2014, Mawuli Adzaku
%%% @doc
%%%
%%% @end
%%% Created : 30 Jan 2014 by Mawuli Adzaku <mawuli@mawuli.me>
%%%-------------------------------------------------------------------
-module(fakerl).
-author("Mawuli Adzaku <mawuli@mawuli.me>").
-include("fakerl.hrl").
-compile([export_all]).

%%%-------------------------------------------------------------------
%%% Interface to commonly used fake data generators
%%%-------------------------------------------------------------------
name() ->
    fakerl_names:name().

address() ->
    undefined.

text() ->
    undefined.

%%%-------------------------------------------------------------------
%%% core/shared logic
%%%-------------------------------------------------------------------

%% @doc Returns a random number betweeen 0 and 10
-spec random_number() -> integer().
random_number() ->
    random(0,10).

%% @doc Returns a random alphabetic character
-spec random_letter() -> char().
random_letter() ->
    Int = random($a, $z),
    [Int].

%% @doc Returns a random uppercase alphabetic character
-spec random_letter(caps) -> char().
random_letter(caps) ->
    Int = random($A, $Z),
    [Int].

%% @doc Returns a randomly selected element from the list provided.
-spec random_element(list()) -> integer().
random_element([]) ->
    error(empty_list);
random_element([X|[]]) ->
    X;
random_element(Xs) ->
    N = random(1,length(Xs)),
    lists:nth(N, Xs).

%% @doc Returns a randomly selected number between From, and To.
-spec random(From, To) -> RandomElement when
      From :: integer(),
      To :: integer(),
      RandomElement :: any().     
random(From, To) ->
   crypto:rand_uniform(From, To).

%% @doc Compiles the format template into a string.
-spec parse(Template, Module) -> {Status, string()} when
      Template :: string(),
      Module :: atom(),
      Status :: error | match | nomatch.
parse([], _Template) ->
    {error, empty_string};
parse(Template, Module) ->
    case re:run(Template, ?VAR_REGEX, [global, {capture, all, list}]) of 
        nomatch ->
            {error, nomatch};
        {match, Matches} ->
            render(Matches, Template, Module)
    end.

%% @doc Replaces all regex matches with equivalent function calls
%% in the given module
-spec render(RegexMatches, Template, Module) -> RenderedTemplate when
      RegexMatches :: regex_match_list(),
      Template :: string(),
      Module :: atom(),
      RenderedTemplate :: list().
render([], Template, _Module) ->
    Bin = iolist_to_binary(Template),
    binary_to_list(Bin);
render([[Regex, Function]|Tail], Template, Module) ->
    Function1 = list_to_atom(Function),
    Value = Module:Function1(),
    Template1 = re:replace(Template, Regex, Value),
    render(Tail, Template1, Module).

%% @doc Converts a string of N "#" into N integers
-spec numerify(String :: string()) -> [integer()].
numerify(String) ->
    numerify(String, []).
numerify([], Acc) ->
    list_to_str(lists:flatten(Acc));
numerify([X|Xs], Acc) when X =:= $# ->
    N = fakerl:random_number(),
    numerify(Xs, [Acc|[N]]).

%% @doc Convert a list of integers into a string
-spec list_to_str([integer()]) -> string().
list_to_str(L) when is_list(L) ->
    L2 = [integer_to_list(X) || X <- L],
    L3 = iolist_to_binary(L2),
    binary_to_list(L3).
