class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        chars = set()
        n = len(s)
        length = 0
        l = 0

        for r in range(n):
            while s[r] in chars:
                chars.remove(s[l])
                l += 1

            CurLen = r - l + 1
            length = max(CurLen, length)
            chars.add(s[r])

        return length

                
        