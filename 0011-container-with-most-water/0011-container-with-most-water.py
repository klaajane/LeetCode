class Solution:
    def maxArea(self, height: List[int]) -> int:
        
        l, r = 0, len(height) - 1
        CurrArea = 0

        while l < r:
            w = r - l
            h = min(height[l], height[r])
            area = w * h
            CurrArea = max(CurrArea, area)
            ## MaxArea was used before it was assigned

            if height[l] < height[r]: 
                ## move the pointer with the shortest height
                ## to find the larger area
                l += 1
            
            else:
                r -= 1

        return CurrArea


