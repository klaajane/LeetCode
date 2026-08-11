class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        seen = {}

        for i, num in enumerate(nums):
            seen[num] = i

        for i, num in enumerate(nums):
            desired = target - num

            if desired in seen and seen[desired] != i:
                return i, seen[desired]

        return []   
                  
                