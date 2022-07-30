import ArgumentParser
import Foundation
import VDK


extension VCLI {
    
    public struct NewSeedPhrase: ParsableCommand {

        // MARK: - Init
        
        public init() {}


        // MARK: - ParsableCommand

        public static var configuration = CommandConfiguration(
            abstract: "Creates a new BIP39 mnemonic seed phrase."
        )

        
        @Flag(
            exclusivity: .exclusive,
            help: """
            The total number of words in the seed phrase.
            """
        )
        public var wordCount: SeedLength = .twelveWords
        
        
        public func run() throws {
            var error: NSError?
            
            let phrase = VDKNewPhrase(wordCount.rawValue, &error)
            
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
    
    public enum SeedLength: Int, EnumerableFlag {
        case twelveWords = 12
        case fifteenWords = 15
        case eighteenWords = 18
        case twentyFourWords = 24
    }
}


extension VCLI.NewSeedPhrase.SeedLength {
    
    public static func name(for value: Self) -> NameSpecification {
        switch value {
        case .twelveWords:
            return [.customLong("12-words")]
        case .fifteenWords:
            return [.customLong("15-words")]
        case .eighteenWords:
            return [.customLong("18-words")]
        case .twentyFourWords:
            return [.customLong("24-words")]
        }
    }
}
