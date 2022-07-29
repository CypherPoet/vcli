import ArgumentParser
import Foundation
import VDK


extension VCLI {

    public struct CreateContract: ParsableCommand {
        
        // MARK: - Init
        
        public init() {}
        
        
        // MARK: - ParsableCommand

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
}
