package pp.block2.cc.ll;

import pp.block2.cc.NonTerm;
import pp.block2.cc.Symbol;
import pp.block2.cc.Term;

import java.util.*;

/**
 * Created by rens.
 */
public class MyLLCalc implements LLCalc {
    public Grammar grammar;
    public Map<Symbol, Set<Term>> first;
    public Map<NonTerm, Set<Term>> follow;
    public Map<Rule, Set<Term>> firstp;

    public MyLLCalc(Grammar grammar) {
        this.grammar = grammar;
    }

    @Override
    public Map<Symbol, Set<Term>> getFirst() {
        if (this.first == null) {
            this.first = buildFirst();
        }
        return this.first;
    }

    @Override
    public Map<NonTerm, Set<Term>> getFollow() {
        if (this.follow == null) {
            this.follow = buildFollow();
        }
        return this.follow;
    }

    @Override
    public Map<Rule, Set<Term>> getFirstp() {
        if (this.firstp == null) {
            this.firstp = buildFirstp();
        }
        return this.firstp;
    }

    @Override
    public boolean isLL1() {
        Map<Rule, Set<Term>> firstp = getFirstp();
        System.out.println(firstp);

        for (Rule rule : grammar.getRules()) {
            for (Rule otherRule : grammar.getRules()) {
                if (rule == otherRule) continue;
                if (rule.getLHS().equals(otherRule.getLHS())) {
                    if (!Collections.disjoint(firstp.get(rule), firstp.get(otherRule))) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    private Map<Symbol, Set<Term>> buildFirst() {
        Map<Symbol, Set<Term>> first = new HashMap<>();
        boolean changing = true;

        for (Term terminal : this.grammar.getTerminals()) {
            // for each terminal in T `U` eof `U` e, add terminal to first
            first.put(terminal, Collections.singleton(terminal));
        }
        for (NonTerm nonTerminal : this.grammar.getNonterminals()) {
            // for each nonTerminal in nonTerminals, add empty set
            first.put(nonTerminal, new HashSet<Term>());
        }

        while (changing) {
            // do this while first sets are still changing
            changing = false;
            // for each rule do:
            for (Rule rule : grammar.getRules()) {
                Set<Term> lhsTerminals = first.get(rule.getLHS());
                Set<Term> rhsTerminals = getrhsFirst(first, rule.getRHS());
                if (!lhsTerminals.containsAll(rhsTerminals)) {
                    // so, sets are still changing
                    // first(A) = (first(A) `U` rhs
                    lhsTerminals.addAll(rhsTerminals);
                    changing = true;
                }
            }
        }
        return first;
    }

    private Set<Term> getrhsFirst(Map<Symbol, Set<Term>> first, List<Symbol> rhs) {
        Set<Term> terminals = new HashSet<>();
        terminals.add(Symbol.EMPTY);
        boolean canBeEmpty = true;
        for (Symbol symbol : rhs) {
            Set<Term> newTerminals = first.get(symbol);
            terminals.addAll(newTerminals);
            canBeEmpty = newTerminals.contains(Symbol.EMPTY);
            if (!canBeEmpty) break;
        }
        if (!canBeEmpty) terminals.remove(Symbol.EMPTY);
        return terminals;
    }

    private Map<NonTerm, Set<Term>> buildFollow() {
        Map<Symbol, Set<Term>> first = getFirst();
        Map<NonTerm, Set<Term>> follow = new HashMap<>();
        boolean changing = true;

        for (NonTerm nonTerminals : grammar.getNonterminals()) {
            // for each A in NT (nonTerminals): add empty set to Follow(A)
            follow.put(nonTerminals, new HashSet<>());
        }
        // follow(S) <- {eof}
        follow.get(grammar.getStart()).add(Symbol.EOF);

        while (changing) {
            changing = false;
            for (Rule rule : grammar.getRules()) {
                NonTerm lhs = rule.getLHS();
                List<Symbol> rhs = rule.getRHS();
                Set<Term> trailer = new HashSet<>(follow.get(lhs));  // trailer <- follow(A)
                for (int i = rhs.size()-1; i >= 0; i--) {
                    Symbol symbol = rhs.get(i);
                    if (symbol instanceof NonTerm) {
                        // bi `e` NT
                        Set<Term> followbi = follow.get(symbol);
                        if (!followbi.containsAll(trailer)) {
                            // follow(bi) <- follow(bi) `U` trailer
                            followbi.addAll(trailer);
                            changing = true;
                        }
                    }
                    if (first.get(symbol).contains(Symbol.EMPTY)) {
                        // trailer <- trailer `U` (first(b1) - e)
                        HashSet<Term> newTrailer = new HashSet<>(first.get(symbol));
                        newTrailer.remove(Symbol.EMPTY);
                        trailer.addAll(newTrailer);
                    }
                    else {
                        // trailer <- first(b1)
                        trailer.clear();
                        trailer.addAll(first.get(symbol));
                    }
                }
            }
        }
        return follow;
    }

    private Map<Rule, Set<Term>> buildFirstp() {
        Map<Rule, Set<Term>> firstp = new HashMap<>();
        Map<Symbol, Set<Term>> first = getFirst();
        Map<NonTerm, Set<Term>> follow = getFollow();

        for (Rule rule : grammar.getRules()) {
            Set<Term> firstp2 = getrhsFirst(first, rule.getRHS());
            if (firstp2.contains(Symbol.EMPTY)) {
                firstp2.addAll(follow.get(rule.getLHS()));
            }
            firstp.put(rule, firstp2);
        }
        return firstp;
    }
}
