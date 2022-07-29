import ArgumentParser
import Foundation
import VDK


extension VCLI {
    
    public struct GetAccount: ParsableCommand {
        
        // MARK: - Init
        
        public init() {}
        
        
        // MARK: - ParsableCommand

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
}
