import Foundation
import ArgumentParser

import VDK

struct Stacks: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "utility for deriving stacks/bitcoin addresses and creating signed transactions",
        version: "0.0.1",
        subcommands: [NewSeedPhrase.self, GetAccount.self, TokenTransfer.self, CreateContract.self, Broadcast.self]
    )
    
    struct NewSeedPhrase: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "create a new seed phrase.")

        @Option(name: [.customLong("length"), .customShort("l")], help: "total words in seed phrase, between 12 - 24.")
        var length = 24
        
        func run() throws {
            var error: NSError?

            let phrase = VDKNewPhrase(length, &error)

            if error != nil {
                throw error!
            }

            print(phrase)
        }
    }
    
    struct GetAccount: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "get a stacks/bitcoin address from a seed phrase.")

        @Option(name: [.customLong("phrase"), .customShort("P")], help: "seed phrase.")
        var phrase = ""
        
        @Option(name: [.customLong("account"), .customShort("A")], help: "index of account.")
        var account = 0
        
        @Option(name: [.customLong("password"), .customShort("W")], help: "password.")
        var password = ""
        
        func run() throws {
            var error: NSError?

            let wallet = VDKNewWalletFromPhrase(phrase, password, &error)

            if error != nil {
                throw error!
            }

            let account_ = try! wallet!.account(account)

            let stacks = account_.principal!.stacks(&error)

            if error != nil {
                throw error!
            }

            print("stacks: ", stacks)

            let bitcoin = account_.principal!.bitcoin(&error)

            if error != nil {
                throw error!
            }

            print("bitcoin:", bitcoin)
        }
    }
    
    struct TokenTransfer: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "create a token transfer.")

        @Option(name: [.customLong("phrase"), .customShort("P")], help: "seed phrase.")
        var phrase = ""
        
        @Option(name: [.customLong("account"), .customShort("A")], help: "index of account.")
        var account = 0
        
        @Option(name: [.customLong("password"), .customShort("W")], help: "password.")
        var password = ""
        
        @Option(name: [.customLong("recipient"), .customShort("R")], help: "recipient.")
        var recipient = ""
        
        @Option(name: [.customLong("amount"), .customShort("S")], help: "amount listed in uSTX.")
        var amount = 0
        
        @Option(name: [.customLong("memo"), .customShort("M")], help: "memo.")
        var memo = ""
        
        func run() throws {
            var error: NSError?

            let wallet = VDKNewWalletFromPhrase(phrase, password, &error)

            if error != nil {
                throw error!
            }

            let derived = try! wallet!.account(account)

            let principal = VDKPrincipal(recipient)
            let transfer = VDKNewTokenTransfer(principal, amount, memo, &error)
            
            if error != nil {
                throw error!
            }
            
            try! transfer!.sign(derived)
            
            let encoded = transfer!.encode(&error)
            
            if error != nil {
                throw error!
            }
            
            print(encoded)
        }
    }
    
    struct CreateContract: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "create a smart contract.")

        @Option(name: [.customLong("phrase"), .customShort("P")], help: "seed phrase.")
        var phrase = ""
        
        @Option(name: [.customLong("account"), .customShort("A")], help: "index of account.")
        var account = 0
        
        @Option(name: [.customLong("password"), .customShort("W")], help: "password.")
        var password = ""
        
        @Option(name: [.customLong("name"), .customShort("N")], help: "name of the contract.")
        var name = ""
        
        @Option(name: [.customLong("body"), .customShort("B")], help: "body of the contract.")
        var body = ""
        
        func run() throws {
            var error: NSError?

            let wallet = VDKNewWalletFromPhrase(phrase, password, &error)

            if error != nil {
                throw error!
            }

            let account_ = try! wallet!.account(account)

            let smartContract = VDKNewSmartContract(name, body, &error)
            
            if error != nil {
                throw error!
            }
            
            try! smartContract!.sign(account_)
            
            let encoded = smartContract!.encode(&error)
            
            if error != nil {
                throw error!
            }
            
            print(encoded)
        }
    }
    
    struct Broadcast: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "broadcast a transaction.")

        @Option(name: [.customLong("phrase"), .customShort("P")], help: "seed phrase.")
        var phrase = ""
        
        @Argument(help: "hex encoded transaction.")
        var transaction: String
        
        func run() throws {
            var error: NSError?
 
            let transaction_ = VDKParseStacksTransaction(transaction, &error)
            
            if error != nil {
                throw error!
            }
            
            try! transaction_!.broadcast()
        }
    }
}

Stacks.main()
