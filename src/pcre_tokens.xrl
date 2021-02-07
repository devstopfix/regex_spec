Definitions.

INT          = [0-9]+
WHITESPACE   = [\s\t\n\r]

Rules.

%% Escaped characters are skipped
\\.            : skip_token.
%% Captures (..)
\(             : {token, {'(',  TokenLine}}.
\)             : {token, {')',  TokenLine}}.
%% Modifiers
\?             : {token, {'?',  TokenLine}}.

%%{INT}          : {token, {int,  TokenLine, list_to_integer(TokenChars)}}.
.              : skip_token.

Erlang code.
