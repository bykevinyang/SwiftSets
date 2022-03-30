func testHashSet() {
    let smallSet = HashSet(size: 5)
    smallSet.insertMany( ["a", "b", "c", "d", "e", "e", "e"] )
    let bigSet = HashSet(size: 10)
    bigSet.insertMany( ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"] )

    print(bigSet)
    print(smallSet.contains("a"))
    print(smallSet.contains("j"))
    print(smallSet.allElements())
    print(smallSet)
    print(smallSet.count)

    print(smallSet.isSubsetOf(bigSet))
    print(bigSet.isSubsetOf(smallSet))
    print(bigSet.statistics)

    for item in bigSet {
        print(item)
    }

    bigSet.resize(newSize: 20)
    print(bigSet)
    print(bigSet.statistics)
}

func testLinearSet() {
    let smallSet = LinearSet()
    smallSet.insertMany( ["a", "b", "c", "d", "e", "e", "e"] )
    let bigSet = LinearSet()
    bigSet.insertMany( ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"] )

    print(bigSet)
    print(smallSet.contains("a"))
    print(smallSet.contains("j"))
    print(smallSet.allElements())
    print(smallSet)
    print(smallSet.count)

    print(smallSet.isSubsetOf(bigSet))
    print(bigSet.isSubsetOf(smallSet))
}

testHashSet()
// testLinearSet()