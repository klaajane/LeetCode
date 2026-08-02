class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        size = len(nums)
        frequency = size / 2

        num_counter = {}

        for i in nums:
            if i not in num_counter:
                num_counter[i] = 1
            else:
                num_counter[i] += 1
        
            if num_counter[i] > frequency:
                return i
        