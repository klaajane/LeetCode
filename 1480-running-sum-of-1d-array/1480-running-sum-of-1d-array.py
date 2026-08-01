class Solution:
    def runningSum(self, nums: List[int]) -> List[int]:

        cumSum = 0

        for i, num in enumerate(nums):
            cumSum += nums[i]
            nums[i] = cumSum
    
        return nums

        