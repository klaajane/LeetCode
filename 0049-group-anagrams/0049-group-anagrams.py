class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:

        anagram_helper = {}

        for word in strs:
            sorted_words = sorted(word)
            key = tuple(sorted_words)

            if key not in anagram_helper:
                anagram_helper[key] = [word]
            else:
                anagram_helper[key].append(word)
        
        return list(anagram_helper.values())