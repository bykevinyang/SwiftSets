class HashSet: CustomStringConvertible, Sequence, IteratorProtocol{
    var set: [String?] 
    var size: Int

    var collisionSet: LinearSet
    var collisionCount: Int

    var insertCount: Int
    var containsCount: Int
    var containCollisionsCount: Int

    var iterCount: Int
    
    init(size: Int) {
        self.size = size
        self.set = Array(repeating: nil, count: size)
        self.collisionSet = LinearSet()

        self.collisionCount = 0
        self.insertCount = 0
        self.containsCount = 0
        self.containCollisionsCount = 0

        self.iterCount = 0
    }

    var count: Int {
        let flattenedHash = self.set.flatMap { $0 }
        return flattenedHash.count + self.collisionSet.count
    }

    var hashSetCount: Int {
        let flattenedHash = self.set.flatMap { $0 }
        return flattenedHash.count
    }

    var collisionSetCount: Int {
        return self.collisionSet.count
    }

    var totalOperations: Int {
        // return self.insertcount + self.containscount + self.containcollisionscount
        return self.insertCount + self.containsCount 
    }

    var collisionYield: Double {
        if totalOperations == 0 { return 0.0 }

        return (Double(self.collisionCount) / Double(self.totalOperations)) * 100.0
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
                print("Collision: \(k) and \(element): \(hash) \(self.set[hash])")
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
                print("already exists!, \(s)")
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

    func resize(newSize: Int) {

        if self.size > newSize {
            print("Error: new size is smaller than current size")
        }
        
        if self.size == newSize {
            print("Why would you resize to the same size, lol")
            return
        }

        self.set = self.set + Array(repeating: nil, count: newSize - self.count)

        self.collisionCount = 0
        self.insertCount = 0
        self.containsCount = 0
        self.containCollisionsCount = 0
        
        self.size = newSize
    }

    var statistics: String {
        var repr: String = "Hash Map Statistics Report:\n"
        repr += "\tHash Array Size: \(self.size)\n"
        repr += "\tHash Array Elements: \(self.hashSetCount)\n"
        repr += "\tCollision Set number elements: \(self.collisionSetCount)\n"
        repr += "\tTotal Elements: \(self.count)\n"
        repr += "\tTotal Inserts: \(self.insertCount)\n"
        repr += "\tInsert Collisions: \(self.collisionCount)\n"
        repr += "\tTotal Contains: \(self.containsCount)\n"
        repr += "\tContains Collisions: \(self.containCollisionsCount)\n"
        repr += "\tTotal Operations: \(self.totalOperations)\n"
        repr += "\tTotal Collisions: \(self.collisionCount)\n"
        repr += "\tCollision Yield (%): \(self.collisionYield)%\n"
        return repr
    }

    func next() -> String? {
        if isEmpty() {
            return nil
        }

        if iterCount == allElements().count {
            iterCount = 0
            return nil
        }

        defer {
            iterCount += 1
        }

        return allElements()[iterCount]
    }
}