class Solution:
    def threeSum(self, nums: list[int]) -> list[list[int]]:
        
        nums.sort() ## need to sort the array
        n = len(nums)
        answer = []

        for i in range(n):
            if nums[i] > 0: 
                break
            elif i > 0 and nums[i] == nums[i-1]: # to avoid duplicates
                continue   

            lo, hi = i+1, n-1
            while lo < hi:
                summ = nums[lo] + nums[hi] + nums[i]
                if summ == 0:
                    answer.append([nums[lo], nums[hi], nums[i]])
                    lo, hi = lo + 1, hi - 1

                    while lo < hi and nums[lo] == nums[lo-1]:
                        lo += 1

                    while lo < hi and nums[hi] == nums[hi+1]:
                        hi -= 1

                elif summ < 0:
                    lo += 1

                else:
                    hi -= 1

        return answer