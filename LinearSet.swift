class LinearSet: CustomStringConvertible {
    var set: [String]
    
    init() {
        self.set = []
    }
    var count: Int {
        return self.set.count
    }
    func isEmpty()-> Bool {
        if self.count == 0 {
            return true
        }
        return false
    }
    func contains(_ s: String) -> Bool {
        for element in self.set {
            if s == element {
                return true
            }
        }
        return false
    }
    func insert(_ s: String) {
        if !self.contains(s) {
            self.set.append(s)
        }
    }
    func insertMany(_ items: [String]) {
        for item in items {
            self.insert(item)
        }
    }
    func remove(_ s: String) {
        for (i, element) in self.set.enumerated() {
            if element == s {
                self.set.remove(at: i)
            }
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
        return self.set
    }

    var description: String {
        var repr: String = "[ "
        
        for element in self.set {
            repr += "\(element) "
        }
        
        repr += "]"
        
        return repr
    }  
}
