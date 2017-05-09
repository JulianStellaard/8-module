package pp.block1.cc.antlr;

import org.junit.Test;
import pp.block1.cc.test.LexerTester;

/**
 * Created by rens on 1-5-17.
 */
public class LaLaTest {
    private static LexerTester tester = new LexerTester(LaLa.class);

    @Test
    public void test() {
        // first token
        tester.correct("La");
        tester.correct("Laaaa    ");
        // second token
        tester.correct("LaLa");
        tester.correct("La La");
        tester.correct("Laa Laaa    ");
        // first and second token combined
        tester.correct("LaLaLa");
        tester.correct("La Laaaaa Laaaaaaaaaaaa                      ");
        // fourth token
        tester.correct("LaLaLaLi");
        tester.correct("La La   Laaaaa Li   ");

        tester.wrong("LLa");
        tester.wrong("LaLi");
        tester.wrong("Li");
        tester.wrong("LaLaLi");
        tester.wrong("LaaaLaaaLaaaLii");

    }
}
