lexer grammar LaLa;

fragment LApart : 'L' ('a')+ (' ')*;
fragment LIpart : 'Li' (' ')*;

LA : LApart;
LALA : LA LA;
LALALALI : LA LA LA LIpart;

/* Do this above (fragments) or below (with 'instant' identifiers)?
 LA : 'L' ('a')+ (' ')*;
 LALA : LA LA;
 LI : 'Li' (' ')*;
 LALALALI : LA LA LA LI;
*/