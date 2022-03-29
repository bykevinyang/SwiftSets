class HashSet: CustomStringConvertible {
    var set: [String?] 
    var size: Int

    var collisionSet: LinearSet
    var collisionCount: Int

    var insertCount: Int
    var containsCount: Int
    var containCollisionsCount: Int
    
    init(size: Int) {
        self.size = size
        self.set = Array(repeating: nil, count: size)
        self.collisionSet = LinearSet()
        self.collisionCount = 0
        self.insertCount = 0
        self.containsCount = 0
        self.containCollisionsCount = 0
        // self.totalOperations = 0
    }

    var totalCount: Int {
        let flattenedHash = self.set.flatMap { $0 }
        return flattenedHash.count + self.collisionSet.count
    }

    var count: Int {
        let flattenedHash = self.set.flatMap { $0 }
        return flattenedHash.count
    }

    var totalOperations: Int {
        return self.insertCount + self.containsCount + self.containCollisionsCount
    }

    func isEmpty() -> Bool {
        return self.count == 0
    }

    func suckyHash(_ item: String)->Int {
        return abs(item.hashValue) % self.size
    }

    func contains(_ k: String) -> Bool {
        self.containsCount += 1
        let hash = self.suckyHash(k)
        if let element = self.set[hash] {
            if element == k {
                return true
            } else {
                self.containCollisionsCount += 1
                return self.collisionSet.contains(k)
            }
        }
        return false
    }

    func insert(_ s: String) {
        self.insertCount += 1
        let hash = self.suckyHash(s)
        if self.set[hash] == nil {
            self.set[hash] = s
        } else {
            if self.set[hash] == s { // If it already exists, do nothing
                return
            } else {
                self.collisionSet.insert(s)
                self.collisionCount += 1
            }
        }
    }

    func insertMany(_ s: [String]) {
        for element in s {
            self.insert(element)
        }
    }

    func isSubsetOf(_ aSet: HashSet ) -> Bool {
        for element in self.set {
            if let e = element {
                if !aSet.contains(e) {
                    return false
                }
            }
        }
        
        for element in self.collisionSet.allElements() { // See if it also fits within the collisions set
            if !aSet.contains(element) {
                return false
            }
        }

        return true
    }

    func allElements()-> [String] {
        var elements: [String] = []

        for element in self.set {
            if let e = element {
                elements.append(e)
            }
        }
        for element in self.collisionSet.allElements() {
            elements.append(element)
        }

        return elements
    }

    var description: String {
        var repr: String = "[ "
        
        for element in self.allElements() {
            repr += "\(element) "
        }
        
        repr += "]"
        
        return repr
    }

    var statistics: String {
        var repr: String = "Hash Map Statistics Report:\n"
        repr += "\tHash Array Size: \(self.size)\n"
        repr += "\tHash Array Elements: \(self.count)\n"
        repr += "\tCollision Set number elements: \(self.collisionSet.count)\n"
        repr += "\tTotal Elements: \(self.totalCount)\n"
        repr += "\tTotal Inserts: \(self.insertCount)\n"
        repr += "\tInsert Collisions: \(self.collisionCount)\n"
        repr += "\tTotal Contains: \(self.containsCount)\n"
        repr += "\tContains Collisions: \(self.collisionCount)\n"
        repr += "\tTotal Operations: \(self.totalOperations)\n"
        repr += "\tTotal Collisions: \(self.collisionCount)\n"
        repr += "Collision Yield (%): \((Double(self.collisionCount) / Double(self.totalOperations)) * 100.0)\n"
        return repr
    }
}