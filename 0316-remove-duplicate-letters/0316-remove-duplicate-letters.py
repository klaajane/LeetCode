class Solution:
    def removeDuplicateLetters(self, s: str) -> str:
        seen = set() # stores unique characters, no dups
        string_builder  = []
        last_pos = {char: i for i, char in enumerate(s)}
        
        for i, c in enumerate(s):
            if c not in seen:
                while string_builder and c < string_builder[-1] and i < last_pos[string_builder[-1]]:
                    seen.discard(string_builder.pop())

                seen.add(c)
                string_builder.append(c)

        return "".join(string_builder)
