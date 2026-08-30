class MinStack:

    def __init__(self):
        self.s = []
        self.min = []

    def push(self, value: int) -> None:
        self.s.append(value)
        value = min(value, self.min[-1] if self.min else value)
        self.min.append(value)

    def pop(self) -> None:
        self.s.pop()
        self.min.pop()

    def top(self) -> int:
        return self.s[-1]

    def getMin(self) -> int:
        return self.min[-1]


# Your MinStack object will be instantiated and called as such:
# obj = MinStack()
# obj.push(value)
# obj.pop()
# param_3 = obj.top()
# param_4 = obj.getMin()