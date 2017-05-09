package pp.block1.cc.antlr;

import org.junit.Test;
import pp.block1.cc.test.LexerTester;

/**
 * Created by rens on 1-5-17.
 */
public class SixCharacterTest {
    private static LexerTester tester = new LexerTester(SixCharacters.class);

    @Test
    public void test() {
        tester.correct("abcABC");
        tester.correct("abc123");
        tester.wrong("abc");
        tester.wrong("abcabcabc");
        tester.wrong("1abcde");
        tester.wrong("&");
    }
}
