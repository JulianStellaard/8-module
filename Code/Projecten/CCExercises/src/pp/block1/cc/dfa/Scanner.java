package pp.block1.cc.dfa;

import java.util.List;

/** Algorithm interface for generating a list of tokens. */
public interface Scanner {
	/**
	 * Returns the list of tokens generated by a given DFA when scanning a given
	 * input text; or <code>null</code> if the input text is not accepted.
	 * Scanning is greedy; i.e., it should always return the longest acceptable
	 * token.
	 */
	List<String> scan(State dfa, String text);
}


