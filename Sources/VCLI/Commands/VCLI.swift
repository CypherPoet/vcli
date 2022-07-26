import Foundation
import ArgumentParser

import VDK

public struct VCLI: ParsableCommand {

    public init() {}
    
    public static var configuration = CommandConfiguration(
        abstract: "utility for deriving stacks/bitcoin addresses and creating signed transactions",
        version: "0.0.1",
        subcommands: [
            NewSeedPhrase.self,
            GetAccount.self,
            TokenTransfer.self,
            CreateContract.self,
            Broadcast.self
        ]
    )
    
    
    public struct NewSeedPhrase: ParsableCommand {
        
        public init() {}
        
        public static var configuration = CommandConfiguration(abstract: "create a new seed phrase.")
        
        @Option(name: [.customLong("length"), .customShort("l")], help: "total words in seed phrase, between 12 - 24.")
        public var length = 24
        
        public func run() throws {
            var error: NSError?
            
            let phrase = VDKNewPhrase(length, &error)
            
            if error != nil {
                throw error!
            }
            
            print(phrase)
        }
    }
    
    
    public struct GetAccount: ParsableCommand {
        
        public init() {}
        
        public static var configuration = CommandConfiguration(abstract: "get a stacks/bitcoin address from a seed phrase.")
        
        @Option(name: [.customLong("phrase"), .customShort("P")], help: "seed phrase.")
        public var phrase = ""
        
        @Option(name: [.customLong("account"), .customShort("A")], help: "index of account.")
        public var account = 0
        
        @Option(name: [.customLong("password"), .customShort("W")], help: "password.")
        public var password = ""
        
        public func run() throws {
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
    
    
    public struct TokenTransfer: ParsableCommand {
        
        public init() {}
        
        public static var configuration = CommandConfiguration(abstract: "create a token transfer.")
        
        @Option(name: [.customLong("phrase"), .customShort("P")], help: "seed phrase.")
        public var phrase = ""
        
        @Option(name: [.customLong("account"), .customShort("A")], help: "index of account.")
        public var account = 0
        
        @Option(name: [.customLong("password"), .customShort("W")], help: "password.")
        public var password = ""
        
        @Option(name: [.customLong("recipient"), .customShort("R")], help: "recipient.")
        public var recipient = ""
        
        @Option(name: [.customLong("amount"), .customShort("S")], help: "amount listed in uSTX.")
        public var amount = 0
        
        @Option(name: [.customLong("memo"), .customShort("M")], help: "memo.")
        public var memo = ""
        
        public func run() throws {
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
    
    
    public struct CreateContract: ParsableCommand {
        
        public init() {}
        
        public static var configuration = CommandConfiguration(abstract: "create a smart contract.")
        
        @Option(name: [.customLong("phrase"), .customShort("P")], help: "seed phrase.")
        public var phrase = ""
        
        @Option(name: [.customLong("account"), .customShort("A")], help: "index of account.")
        public var account = 0
        
        @Option(name: [.customLong("password"), .customShort("W")], help: "password.")
        public var password = ""
        
        @Option(name: [.customLong("name"), .customShort("N")], help: "name of the contract.")
        public var name = ""
        
        @Option(name: [.customLong("body"), .customShort("B")], help: "body of the contract.")
        public var body = ""
        
        public func run() throws {
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
    
    
    public struct Broadcast: ParsableCommand {
        
        public init() {}
        
        public static var configuration = CommandConfiguration(abstract: "broadcast a transaction.")
        
        @Option(name: [.customLong("phrase"), .customShort("P")], help: "seed phrase.")
        public var phrase = ""
        
        @Argument(help: "hex encoded transaction.")
        public var transaction: String
        
        public func run() throws {
            var error: NSError?
            
            let transaction_ = VDKNewStacksTransaction(transaction, &error)
            
            if error != nil {
                throw error!
            }
            
            try! transaction_!.broadcast()
        }
    }
}
