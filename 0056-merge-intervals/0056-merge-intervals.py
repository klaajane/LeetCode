class Solution:
    def merge(self, intervals: List[List[int]]) -> List[List[int]]:
        # only two numbers in each list
        # num1(left) < num2(right)
        # num2(left) < num1(right)
        intervals.sort(key = lambda interval: interval[0])
        merged = []

        for interval in intervals:
            if not merged or merged[-1][1] < interval[0]:
                merged.append(interval)
            else:
                merged[-1] = [merged[-1][0], max(merged[-1][1], interval[1])]

        return merged