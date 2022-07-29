import ArgumentParser
import Foundation
import VDK


extension VCLI {
    
    public struct TokenTransfer: ParsableCommand {
    
        // MARK: - Init
        
        public init() {}
        
        
        // MARK: - ParsableCommand

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
}
