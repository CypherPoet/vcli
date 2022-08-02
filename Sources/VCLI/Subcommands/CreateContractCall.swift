import ArgumentParser
import Foundation
import VDK


extension VCLI {

    public struct CreateContractCall: ParsableCommand {
        
        // MARK: - Init
        
        public init() {}
        
        
        // MARK: - ParsableCommand

        public static var configuration = CommandConfiguration(
            abstract: """
            Creates and executes a smart contract function call.
            """
        )
        
        
        @Option(
            name: [
                .customLong("types"),
            ],
            parsing: .upToNextOption,
            help: """
            The types corresponding to the call argument's values.
            """,
            completion: nil
        )
        public var argumentTypes: [CallArgumentType] = []
        
        
        @Option(
            name: [
                .customLong("values"),
            ],
            parsing: .upToNextOption,
            help: """
            The values for each call argument.
            """,
            completion: nil,
            // TODO: Parse and return values typed according to the
            // Swift types that we'd expected would
            // correspond to each `argumentType`.
            transform: { [$0] }
        )
        public var argumentValues: [AnyHashable] = []
        

        @Option(
            name: [
                .customLong("wallet-seed"),
            ],
            help: """
            The wallet seed phrase.
            """
        )
        public var walletSeedPhrase: String
        
        
        @Option(
            name: [
                .customLong("account-index"),
            ],
            help: "The index of account."
        )
        public var accountIndex: Int = 0
        
        
        @Option(
            name: [
                .customLong("wallet-password"),
            ],
            help: """
            The wallet's password.
            """
        )
        public var walletPassword: String = ""
        

        @Option(
            name: [
                .customLong("function-name"),
            ],
            help: """
            The name of the function as listed in the `Clarity` contract.
            """
        )
        public var contractFunctionName: String

        
        public func run() throws {
            var error: NSError?
            
            let wallet = VDKNewWalletFromPhrase(walletSeedPhrase, walletPassword, &error)
            
            guard error == nil else {
                throw Error.failedToGetWallet(error: error!)
            }
            
            
            let account_ = try! wallet!.account(accountIndex)
            
            guard error == nil else {
                throw Error.failedToGetAccountWalletFromAccountIndex(error: error!)
            }

            
            let result = VDKNewContractCall(
                account_.principal!,
                contractFunctionName,
                contractCallArguments,
                &error
            )
            
            guard error == nil else {
                throw Error.failedToExecuteContractCall(error: error!)
            }
            
            
            let encodedResult = result!.encode(&error)
            
            guard error == nil else {
                throw Error.failedToEncodeResult(error: error!)
            }
            
            print(encodedResult)
        }
    }
}


// MARK: -  CallArgumentType

extension VCLI.CreateContractCall {
    
    /// Cases corresponding to a [`ClarityType`](https://github.com/valeralabs/vdk/blob/1ed88b96cf25fc9dc1f4dd7b350166774a2d6e67/encoding/clarity/clarity.go#L20).
    public enum CallArgumentType: String, ExpressibleByArgument {
        case stringASCII
        case unsignedInt
    }
}


// MARK: - Error Handling

extension VCLI.CreateContractCall {
    
    enum Error: Swift.Error {
        case failedToGetWallet(error: Swift.Error)
        case failedToGetAccountWalletFromAccountIndex(error: Swift.Error)
        case failedToEncodeResult(error: Swift.Error)
        case failedToExecuteContractCall(error: Swift.Error)
    }
}


// MARK: - Computeds

extension VCLI.CreateContractCall {

    // 📝 TODO:  Figure out how to properly create a `VDKClarityList` from `argumentTypes`
    // and their corresponding `argumentValues`.
    var contractCallArguments: VDKClarityList? {
        let argumentPairs = zip(argumentTypes, argumentValues)
        let clarityList = VDKClarityList()
        
        for value in argumentValues {
            clarityList?.add(value as? VDKClarityValue)
        }
        
        return clarityList
    }
}
