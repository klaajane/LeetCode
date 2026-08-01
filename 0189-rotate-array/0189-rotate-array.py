class Solution:
    def rotate(self, nums: List[int], k: int) -> None:
        if k >= len(nums):
            k %= len(nums)

        nums_reversed = nums[::-1]
        after_k = nums_reversed[:k][::-1]
        before_k = nums_reversed[k:][::-1]
        nums[:] = after_k + before_k
        
        