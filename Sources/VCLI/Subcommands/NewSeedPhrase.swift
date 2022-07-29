import ArgumentParser
import Foundation
import VDK


extension VCLI {
    
    public struct NewSeedPhrase: ParsableCommand {

        // MARK: - Init
        
        public init() {}


        // MARK: - ParsableCommand

        public static var configuration = CommandConfiguration(abstract: "create a new seed phrase.")
        
        
        @Option(
            name: [
                .customLong("word-count"),
            ],
            help: "The total number of words in seed phrase, between 12 - 24."
        )
        public var length = 24
        
        
        public func run() throws {
            var error: NSError?
            
            let phrase = VDKNewPhrase(length, &error)
            
            if let error {
                throw Error.newPhraseCreationFailed(error: error)
            }

            print(phrase)
        }
    }
}


// MARK: - Error Handling

extension VCLI.NewSeedPhrase {
    
    enum Error: Swift.Error {
        case newPhraseCreationFailed(error: Swift.Error)
    }
}
