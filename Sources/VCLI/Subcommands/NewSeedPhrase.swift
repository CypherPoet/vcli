import ArgumentParser
import Foundation
import VDK


extension VCLI {
    
    public struct NewSeedPhrase: ParsableCommand {

        // MARK: - Init
        
        public init() {}


        // MARK: - ParsableCommand

        public static var configuration = CommandConfiguration(
            abstract: "create a new seed phrase."
        )

        
        @Option(
            name: [
                .long,
            ],
            help: """
            The total number of words in seed phrase, between 12 - 24.
            """,
            transform: Self.parseWordCountArgument
        )
        public var wordCount = 24
        
        
        public func run() throws {
            var error: NSError?
            
            let phrase = VDKNewPhrase(wordCount, &error)
            
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


extension VCLI.NewSeedPhrase {
    
    static func parseWordCountArgument(_ string: String) throws -> Int {
        guard let number = Int(string) else {
            throw ValidationError("Argument must be parsable as an integer.")
        }
        
        guard (12...24).contains(number) else {
            throw ValidationError("Seed phrase must be between 12 and 24 words.")
        }
        
        return number
    }
    
}

