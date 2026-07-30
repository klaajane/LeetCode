from collections import Counter

class Solution:
    def findLucky(self, arr: List[int]) -> int:
        lucky = -1
        counts = Counter(arr)

        for num, count in counts.items():
            if num == count:
                lucky = max(lucky, num)

        return lucky

            
        
