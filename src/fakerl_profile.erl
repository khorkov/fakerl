%%%-------------------------------------------------------------------
%%% @author Mawuli Adzaku <mawuli@mawuli.me>
%%% @copyright (C) 2014, Mawuli Adzaku
%%% @doc
%%% User profile data generator
%%% @end
%%% Created :  5 Feb 2014 by Mawuli Adzaku <mawuli@mawuli.me>
%%%-------------------------------------------------------------------

-module(fakerl_profile).

-export([simple_profile/0,
         profile/0]).


%% @doc Generates a basic profile with personal informations
-spec simple_profile() -> [term()].
simple_profile() ->
    [
     {username, fakerl:parse("{{username}}")},
     {name, fakerl:parse("{{name}}")},
     {address, fakerl:parse("{{address}}")},
     {email, fakerl:parse("{{email}}")},
     {password, fakerl:parse("{{password}}")},
     {birthdate, fakerl:parse("{{birthdate}}")}
    ].

%% @doc Generates a complete profile.
%% @todo: specify fields to return
-spec profile() -> [term()].
profile() ->
    [
     {job, fakerl:parse("{{job}}")}, 
     {company, fakerl:parse("{{company}}")}, 
     {ssn, fakerl:parse("{{ssn}}")},
     {residence, fakerl:parse("{{residence}}")},
     {current_location, fakerl:parse("{{current_location}}")} ,
     {blood_group, fakerl:parse("{{blood_group}}")},
     {website, fakerl:parse("{{website}}")}
    ].    
