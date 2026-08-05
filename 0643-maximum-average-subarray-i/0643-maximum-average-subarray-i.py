class Solution:
    def findMaxAverage(self, nums: List[int], k: int) -> float:
        MaxAvg = float()
        CurSum = 0
        n = len(nums)

        for i in range(k):
            CurSum += nums[i]

        MaxAvg = CurSum / k
        
        for i in range(k, n):
            CurSum += nums[i]
            CurSum -= nums[i-k]

            avg = CurSum / k
            MaxAvg = max(MaxAvg, avg)

        return MaxAvg