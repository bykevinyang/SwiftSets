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

func inClassBasicHashSetTest(){

    print("\n****begin basic test")

    let smallSet = HashSet(size: 5)

    smallSet.insertMany( ["a", "ab", "abc","abcd","abcde", "abc","ab"])

    let bigSet = HashSet(size: 10)

    bigSet.insertMany(["a", "ab", "abc","abcd","abcde", "ffff","gggg","hhhh","iiii","jjjj"])

    print(bigSet)

    print(smallSet.contains("abcde"))

    print(smallSet.contains("jjjj"))

    print(smallSet.allElements())

    print(smallSet)

    print(smallSet.count)

    print(smallSet.isSubsetOf(bigSet))

    print(bigSet.isSubsetOf(smallSet))

    print(bigSet)

    print(bigSet.statistics)

    print("****end basic test\n")

}

func inClassResizeHashSetTest(){

    print("\n****begin resize test")

    let bigSet = HashSet(size: 10)

    bigSet.insertMany(["a", "ab", "abc","abcd","abcde", "ffff","gggg","hhhh","iiii","jjjj"])

    print(bigSet)

    print(bigSet.statistics)

    bigSet.resize(newSize: 100)

    print(bigSet)

    print(bigSet.statistics)

    bigSet.resize(newSize: 5)

    print(bigSet)

    print(bigSet.statistics)

    bigSet.resize(newSize: 10)

    print(bigSet)

    print(bigSet.statistics)

    print("****end resize test\n")

}

func inClassSequenceHashSetTest(){

    print("\n****begin sequence test")

    let bigSet = HashSet(size: 10)

    bigSet.insertMany(["a", "ab", "abc","abcd","abcde", "ffff","gggg","hhhh","iiii","jjjj"])

    for e in bigSet{print(e)}

    let result = bigSet.map{$0.count}

        .filter{$0 > 3}

        .reduce(0, {$0 + 2 * $1})

    print(result)

    print("****end sequence test\n")

}

// testHashSet()
// testLinearSet()
// inClassBasicHashSetTest()
inClassResizeHashSetTest()
// inClassSequenceHashSetTest()