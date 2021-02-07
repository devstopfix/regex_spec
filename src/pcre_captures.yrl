Nonterminals 
re captures capture.

Terminals 
'(' ')' '?'. 
% int.

Rootsymbol 
re.

captures -> capture : ['$1'].
captures -> capture captures : ['$1' | '$2'].

capture -> '(' ')' '?'   : #{ capture => [], optional => true}.
capture -> '(' ')'       : #{ capture => []}.
capture -> '(' captures ')' : #{ capture => '$2'}.

re -> captures : '$1'.
re -> '$empty' : [].

Erlang code.

% extract_token({_Token, _Line, Value}) -> Value.