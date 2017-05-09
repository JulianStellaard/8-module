package pp.block1.cc.test;

import static pp.block1.cc.dfa.State.DFA_LALA;
import static pp.block1.cc.dfa.State.ID6_DFA;

import org.junit.Assert;
import org.junit.Test;

import pp.block1.cc.dfa.Checker;
import pp.block1.cc.dfa.Check;
import pp.block1.cc.dfa.State;

/** Test class for Checker implementation. */
public class CheckerTest {
	private Checker myChecker = new Check();

	private State dfa;

	@Test
	public void testID6() {
		this.dfa = ID6_DFA;
		accepts("a12345");
		accepts("A12345");
		rejects("");
		rejects("a12 45");
		rejects("a12 456");
		rejects("a123456");
		rejects("123456");
	}

	@Test
    public void testLALA() {
	    this.dfa = DFA_LALA;
	    accepts("La");
	    accepts("Laa    La");
	    accepts("La La La Li");
        rejects("Lii");
        rejects("LaaLiiLa");
        rejects("a");
        rejects("aLaLi");
    }


	private void accepts(String word) {
		if (!this.myChecker.accepts(this.dfa, word)) {
			Assert.fail(String.format(
					"Word '%s' is erroneously rejected by %s", word, this.dfa));
		}
	}

	private void rejects(String word) {
		if (this.myChecker.accepts(this.dfa, word)) {
			Assert.fail(String.format(
					"Word '%s' is erroneously accepted by %s", word, this.dfa));
		}
	}
}
