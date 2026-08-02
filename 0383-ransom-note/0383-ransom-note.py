class Solution:
    def canConstruct(self, ransomNote: str, magazine: str) -> bool:
        magazine_letters = {}

        for letter in magazine:
            if letter not in magazine_letters:
                magazine_letters[letter] = 1
            else:
                magazine_letters[letter] += 1

        for character in ransomNote:
            if character in magazine_letters and magazine_letters[character] != 0:
                magazine_letters[character] -= 1
            else:
                return False

        return True
            