class HashSet: CustomStringConvertible {
    var set: [String?] 
    var size: Int

    var collisionsMap: LinearSet
    var collisionCount: Int

    init(size: Int) {
        self.size = size
        self.set = Array(repeating: nil, count: size)
        self.collisionsMap = LinearSet()
        self.collisionCount = 0
    }

    var count: Int {
        let flattened = self.set.flatMap { $0 }
        return flattened.count
    }

    func isEmpty() -> Bool {
        return self.count == 0
    }

    func suckyHash(_ item: String)->Int {
        return abs(item.hashValue) % self.size
    }

    func contains(_ k: String) -> Bool {
        let hash = self.suckyHash(k)
        if let _ = self.set[hash] {
            return true
        } else {
            return self.collisionsMap.contains(k)
        }
    }

    func insert(_ s: String) {
        let hash = self.suckyHash(s)
        if self.set[hash] == nil {
            self.set[hash] = s
        } else {
            if self.set[hash] == s { // If it already exists, do nothing
                return
            } else {
                self.collisionsMap.insert(s)
                self.collisionCount += 1
            }
        }
    }

    func insertMany(_ s: [String]) {
        for element in s {
            self.insert(element)
        }
    }

    func isSubsetOf(_ aSet: LinearSet ) -> Bool {
        for element in self.set {
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
        for element in self.collisionsMap.allElements() {
            elements.append(element)
        }
        return elements
    }

    var description: String {
        var repr: String = "[ "
        
        for element in self.set {
            if let e = element {
                repr += "\(e) "
            }
        }
        
        repr += "]"
        
        return repr
    }

    var statistics: String {
        return "DO LATER"
    }
}