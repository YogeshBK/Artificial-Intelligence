% DCG for simple English sentences (noun phrase + verb phrase)

% Sentence rule: sentence --> noun_phrase, verb_phrase.
sentence --> noun_phrase, verb_phrase.

% Noun phrase rules: can be either a proper noun or a determiner + noun
noun_phrase --> proper_noun.
noun_phrase --> determiner, noun.

% Verb phrase rules: can be just an intransitive verb, or a transitive verb + noun phrase
verb_phrase --> intransitive_verb.
verb_phrase --> transitive_verb, noun_phrase.

% Lexical rules (vocabulary)
proper_noun --> [john].
proper_noun --> [mary].
proper_noun --> [susan].

determiner --> [the].
determiner --> [a].

noun --> [cat].
noun --> [dog].
noun --> [man].
noun --> [woman].

intransitive_verb --> [sleeps].
intransitive_verb --> [runs].
intransitive_verb --> [jumps].

transitive_verb --> [loves].
transitive_verb --> [chases].
transitive_verb --> [sees].