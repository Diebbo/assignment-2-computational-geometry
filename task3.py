from math import inf
from collections import namedtuple

class Interval:
    def __init__(self, start=-inf, end=inf):
        assert start <= end, "Start must be less than or equal to end"
        self.start = start
        self.end = end
        self.length = end - start

    def __lt__(self, other):
        return self.length < other.length

    def __repr__(self):
        return f"[{self.start}, {self.end}]"
    
    def intersect(self, other):
        new_start = max(self.start, other.start)
        new_end = min(self.end, other.end)
        if new_start <= new_end:
            return Interval(new_start, new_end)
        else:
            return None

    def subtract(self, other):
        if self.end <= other.start or self.start >= other.end:
            return [self]
        elif self.start < other.start and self.end > other.end:
            return [Interval(self.start, other.start), Interval(other.end, self.end)]
        elif self.start < other.start:
            return [Interval(self.start, other.start)]
        elif self.end > other.end:
            return [Interval(other.end, self.end)]
        else:
            return []

    # overwrite & operator
    def __and__(self, other):
        return self.intersect(other)
    
    # overwrite - operator
    def __sub__(self, other):
        return self.subtract(other)

class IntervalSet:
    def __init__(self, intervals=None):
        assert intervals is None or all(isinstance(i, Interval) for i in intervals), "All elements must be Interval instances"
        self.intervals = intervals if intervals else []
        self.normalize()

    def add(self, interval):
        self.intervals.append(interval)
        self.normalize()

    def __repr__(self):
        return "{" + ", ".join(map(str, self.intervals)) + "}"
    
    def normalize(self):
        self.intervals.sort(key=lambda x: x.start)
        normalized = []
        for interval in self.intervals:
            if not normalized or normalized[-1].end < interval.start:
                normalized.append(interval)
            else:
                normalized[-1].end = max(normalized[-1].end, interval.end)
                normalized[-1].length = normalized[-1].end - normalized[-1].start
        self.intervals = normalized

    def intersect_set(self, other):
        result = IntervalSet()
        for interval1 in self.intervals:
            for interval2 in other.intervals:
                intersection = interval1 & interval2
                if intersection:
                    result.add(intersection)
        return result
    
    def intersect_interval(self, interval):
        result = IntervalSet()
        for interval1 in self.intervals:
            intersection = interval1 & interval
            if intersection:
                result.add(intersection)
        return result
    
    def subtract(self, other):
        result = IntervalSet()
        for interval1 in self.intervals:
            temp = [interval1]
            for interval2 in other.intervals:
                new_temp = []
                for sub_interval in temp:
                    new_temp.extend(sub_interval - interval2)
                temp = new_temp
            for sub_interval in temp:
                result.add(sub_interval)
        return result
    
    # overwrite & operator
    def __and__(self, other):
        if isinstance(other, IntervalSet):
            return self.intersect_set(other)
        elif isinstance(other, Interval):
            return self.intersect_interval(other)
        else:
            raise TypeError("Operand must be an Interval or IntervalSet")
    # overwrite - operator
    def __sub__(self, other):
        if isinstance(other, IntervalSet):
            return self.subtract(other)
        elif isinstance(other, Interval):
            return self.subtract(IntervalSet([other]))
        else:
            raise TypeError("Operand must be an Interval or IntervalSet")
        



Point = namedtuple('Point', ['x', 'y'])



def task3(segments):
    '''
    segments: list of tuples (Point, Point)

    The algorithm will check if exists a line that stabs all segments.

    Returns: the line if such line exists, False otherwise.
    
    Iterate through all points
    for each point p:
        create an interval set I = {[-inf, inf]}
        for each segment s:
            if p is not in s:
                create the interval of slopes that would make a line through p intersect s
                if both endpoints of s are to the left or right of p:
                    I = I & interval
                else:
                    I = I - interval
            if I is empty:
                break
        else:
            return the line with slope in I and passing through p
    '''

    for seg in segments:
        for p in seg:
            I = IntervalSet([Interval(-inf, inf)])
            for s in segments:
                if s == seg:
                    continue
                slope1 = (s[0].y - p.y) / (s[0].x - p.x) if s[0].x != p.x else inf*(-1 if s[0].y < p.y else 1)
                slope2 = (s[1].y - p.y) / (s[1].x - p.x) if s[1].x != p.x else inf*(-1 if s[1].y < p.y else 1)
                if p == s[0] or p == s[1]:
                    if s[0] == s[1]:
                        slope_interval = Interval(-inf, inf)
                    else:
                        sl3 = (s[0].y - s[1].y) / (s[0].x - s[1].x) if s[0].x != s[1].x else inf*(-1 if s[0].y < s[1].y else 1)
                else:
                    slope_interval = Interval(min(slope1, slope2), max(slope1, slope2))
                if (s[0].x < p.x and s[1].x < p.x) or (s[0].x > p.x and s[1].x > p.x):
                    I = I & slope_interval
                else:
                    I = I - slope_interval
                if not I.intervals:
                    break
            else:
                # Return a line with slope in I and passing through p
                i = I.intervals[0]
                slope = i.start if i.start > -inf else i.end if i.end < inf else 0
                intercept = p.y - slope * p.x
                return True, (slope, intercept, p)
    return False, None






segments = [ (Point(1, 1), Point(4, 4)), 
             (Point(1, 4), Point(4, 1)),
             (Point(2, 2), Point(2, 5)) ]