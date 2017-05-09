package pp.block1.cc.antlr;

import org.junit.Test;
import pp.block1.cc.test.LexerTester;

/**
 * Created by rens on 1-5-17.
 */
public class PLITest {
    private static LexerTester tester = new LexerTester(PLI.class);

    @Test
    public void test() {
        tester.correct("\"henk\"");
        tester.correct("\"he\"\"nk\"");
        tester.wrong("henk");
        tester.wrong("\"henk");
        tester.wrong("\"he\"nk\"");
    }
}
