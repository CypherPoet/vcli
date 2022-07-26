import XCTest
import VCLI


final class VCLITests: XCTestCase {

    func testExample() throws {
        XCTAssertFalse(
            VCLI.configuration.subcommands.isEmpty
        )
    }
}
