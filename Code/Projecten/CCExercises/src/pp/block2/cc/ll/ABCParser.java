package pp.block2.cc.ll;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.Token;
import pp.block2.cc.*;

import java.util.List;

/**
 * Created by rens.
 */
public class ABCParser implements Parser {

    private final SymbolFactory fact;

    private List<? extends Token> tokens;
    private int index;

    private static final NonTerm L = new NonTerm("L");
    private static final NonTerm R = new NonTerm("R");
    private static final NonTerm X = new NonTerm("X");
    private static final NonTerm Q = new NonTerm("Q");
    private static final NonTerm Y = new NonTerm("Y");


    public ABCParser() {
        this.fact = new SymbolFactory(ABCLexer.class);
    }
    @Override
    public AST parse(Lexer lexer) throws ParseException {
        this.tokens = lexer.getAllTokens();
        this.index = 0;
        return parseABC();
    }

    private AST parseABC() throws ParseException {
        // TODO: parse
        return null;
    }

    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Usage: [text]+");
        } else {
            for (String text : args) {
                CharStream stream = CharStreams.fromString(text);
                Lexer lexer = new ABCLexer(stream);
                try {
                    System.out.printf("Parse tree: %n%s%n",
                            new ABCParser().parse(lexer));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
