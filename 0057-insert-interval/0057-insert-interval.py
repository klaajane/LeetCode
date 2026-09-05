class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:
        ## sort intervals in ascending order by start

        # 1/ merge intervals list with newInterval:

        intervals.append(newInterval)

        # 2/ sort the interval:

        intervals.sort(key = lambda interval:interval[0])

        merged = []

        
        for interval in intervals:
            ## if merged list is empty or the last element doesn't overlap with the current element
            ## we need to append the interval to merged:

            if not merged or merged[-1][1] < interval[0]:
                merged.append(interval)
            else:
                merged[-1] = [merged[-1][0], max(interval[1], merged[-1][1])]

        return merged
