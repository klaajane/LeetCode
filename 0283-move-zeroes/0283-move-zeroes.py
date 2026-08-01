class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        l, left, right = len(nums), 0, 0

        while right < l:
            if nums[right] != 0:
                nums[left], nums[right] = nums[right], nums[left]
                left += 1
            right += 1
        