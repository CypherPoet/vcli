import Foundation
import ArgumentParser
import VDK


public struct VCLI: ParsableCommand {
    
    // MARK: - Init
    
    public init() {}

    
    // MARK: - ParsableCommand
    
    public static var configuration = CommandConfiguration(
        commandName: "vcli",
        abstract: """
        A utility for deriving Stacks/Bitcoin addresses and creating signed transactions.
        """,
        version: "0.0.1",
        subcommands: [
            NewSeedPhrase.self,
            GetAccount.self,
            TokenTransfer.self,
            CreateContract.self,
            CreateContractCall.self,
            Broadcast.self
        ],
        defaultSubcommand: nil
    )
}
