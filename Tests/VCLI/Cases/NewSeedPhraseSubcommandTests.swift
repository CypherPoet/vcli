import XCTest
import ArgumentParser
import VCLI


final class VCLI_NewSeedPhraseTests: XCTestCase {
    internal typealias SystemUnderTest = VCLI.NewSeedPhrase
}


// MARK: - Lifecycle
extension VCLI_NewSeedPhraseTests {

    override func setUp() async throws {
        // Put setup code here.
        // This method is called before the invocation of each
        // test method in the class.

        try await super.setUp()
    }


    override func tearDown() async throws {
        // Put teardown code here.
        // This method is called after the invocation of each
        // test method in the class.

        try await super.tearDown()
    }
}


// MARK: - Test - Default Arguments
extension VCLI_NewSeedPhraseTests {
    
    func test_NewSeedPhrase_WhenUsingDefaultArguments_ItCreatesSeedPhraseWordCountOf12() async throws {
        let expected: SystemUnderTest.SeedLength = .twelveWords
        
        let seedPhrase = try parse(
            SystemUnderTest.self,
            []
        )
        
        XCTAssertEqual(seedPhrase.wordCount, expected)
    }
}
    



// MARK: - Test - `wordCount`
extension VCLI_NewSeedPhraseTests {
    
    func test_wordCount_GivenFlag_ItCreatesSeedPhraseWordCountMatchingFlag() async throws {
        let expected: SystemUnderTest.SeedLength = .eighteenWords

        let seedPhrase = try parse(
            SystemUnderTest.self,
            [
                "--\(expected.longArgumentName)",
            ]
        )

        XCTAssertEqual(seedPhrase.wordCount, expected)
    }
}
