package pp.block1.cc.dfa;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

/**
 * Created by rens on 26-4-17.
 *
 */
public class Scan implements Scanner {

    @Override
    public List<String> scan(State dfa, String text) {
        // tokens to return
        ArrayList<String> tokens = new ArrayList<>();
        while (text.length() > 0) {
            StringBuilder token = new StringBuilder();

            // stack with states
            Stack<State> stack = new Stack<>();

            State state = dfa;
            int i = 0;

            //to explain, set breakpoint at this while loop
            while (state != null && i < text.length()) {
                char c = text.charAt(i);
                token.append(c);
                if (state.isAccepting()) {
                    // clear stack (keep track of what the last accepting state was)
                    stack.clear();
                }

                // put state on stack
                stack.push(state);
                // go to next state
                state = state.getNext(c);
                i++;
            }

            // to explain, set breakpoint at this while loop
            while ((state == null || !state.isAccepting()) && stack.size() > 0) {
                // if state is null, no more states
                // if !state.isAccepting() and stack.size() != 0, there is still a state in the stack, however
                // it isn't accepting. remove the stack from the stack, create token and go to while loop again
                // either the state is null (no more states), or the state is now accepting. in that case,
                // the token `token` is valid
                state = stack.pop();
                token = new StringBuilder(text.substring(0, token.length() - 1));
            }

            tokens.add(token.toString());
            text = text.substring(token.length());
        }
        return tokens;
    }
}
