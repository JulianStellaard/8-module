lexer grammar SixCharacters;

fragment ALPHABET : 'a'..'z'|'A'..'Z';
fragment ALPHANUMBER : (ALPHABET | '0'..'9');

IDENTIFIER: ALPHABET ALPHANUMBER ALPHANUMBER ALPHANUMBER ALPHANUMBER ALPHANUMBER;