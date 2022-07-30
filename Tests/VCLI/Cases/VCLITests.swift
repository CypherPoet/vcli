import XCTest
import VCLI
import ArgumentParser


final class VCLITests: XCTestCase {
    
    func test_RootCommand_ItExposesNewSeedPhraseSubcommand() throws {
        XCTAssertTrue(
            VCLI.configuration.subcommands.contains(where: { commandType in
                commandType is VCLI.NewSeedPhrase.Type
            })
        )
    }
    
    
    func test_RootCommand_ItExposesGetAccountSubcommand() throws {
        XCTAssertTrue(
            VCLI.configuration.subcommands.contains(where: { commandType in
                commandType is VCLI.GetAccount.Type
            })
        )
    }
    
    
    func test_RootCommand_ItExposesTokenTransferSubcommand() throws {
        XCTAssertTrue(
            VCLI.configuration.subcommands.contains(where: { commandType in
                commandType is VCLI.TokenTransfer.Type
            })
        )
    }
    
    
    func test_RootCommand_ItExposesCreateContractSubcommand() throws {
        XCTAssertTrue(
            VCLI.configuration.subcommands.contains(where: { commandType in
                commandType is VCLI.CreateContract.Type
            })
        )
    }
    
    
    func test_RootCommand_ItExposesBroadcastSubcommand() throws {
        XCTAssertTrue(
            VCLI.configuration.subcommands.contains(where: { commandType in
                commandType is VCLI.Broadcast.Type
            })
        )
    }
}
