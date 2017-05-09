package pp.block2.cc.ll;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.atn.ATN;

/**
 * Created by rens.
 */
public class ABCLexer extends Lexer {
    public ABCLexer(CharStream stream) {

    }

    @Override
    public String[] getRuleNames() {
        return new String[0];
    }

    @Override
    public String getGrammarFileName() {
        return null;
    }

    @Override
    public ATN getATN() {
        return null;
    }
}
