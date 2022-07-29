import ArgumentParser
import Foundation
import VDK


extension VCLI {
    
    public struct Broadcast: ParsableCommand {
        
        // MARK: - Init

        public init() {}

        
        // MARK: - ParsableCommand

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
