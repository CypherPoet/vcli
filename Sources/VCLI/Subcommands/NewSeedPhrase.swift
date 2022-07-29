import ArgumentParser
import Foundation
import VDK


extension VCLI {

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
}
