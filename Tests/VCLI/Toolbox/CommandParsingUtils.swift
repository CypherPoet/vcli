import ArgumentParser
import XCTest


func parse<Command>(
    _ type: Command.Type,
    _ arguments: [String]
) throws -> Command
    where Command: ParsableCommand
{
    try XCTUnwrap(Command.parseAsRoot(arguments) as? Command)
}
