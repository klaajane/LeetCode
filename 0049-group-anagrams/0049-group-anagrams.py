class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:

        anagram_helper = {}

        for word in strs:
            sorted_word = sorted(word)
            key = tuple(sorted_word)

            if key not in anagram_helper:
                anagram_helper[key] = [word]

            else:
                anagram_helper[key].append(word)
            
        ans = list(anagram_helper.values())

        return ans

        


        