// © 2026 John Gary Pusey (see LICENSE.md)

internal import Foundation

extension DKMFormatter {

    // MARK: Internal Nested Types

    internal struct Writer {

        // MARK: Internal Initializers

        internal init(score: DKMScore) {
            self.buffer = ""
            self.previous = .comment
            self.score = score
        }

        // MARK: Private Instance Properties

        private let score: DKMScore

        private var buffer: String
        private var previous: DKMCommand
    }
}

// MARK: -

extension DKMFormatter.Writer {

    // MARK: Internal Instance Methods

    internal mutating func writeScore() throws -> Data {
        for entry in score.entries {
            try _writeEntry(entry)
        }

        guard let data = buffer.data(using: .utf8)
        else { throw DKMFormatError.stringConversionFailed }

        return data
    }

    // MARK: Private Instance Methods

    private mutating func _writeArgument(_ argument: DKMArgument) throws {
        switch argument {
        case let .double(value):
            buffer.append("\(value)")

        case let .string(value):
            guard !value.contains(where: \.isNewline)
            else { throw DKMFormatError.invalidStringArgument(value) }

            buffer.append(value)
        }
    }

    private mutating func _writeArguments(_ arguments: [DKMArgument]) throws {
        guard !arguments.isEmpty
        else { return }

        var first = true

        for argument in arguments {
            if !first {
                buffer.append(" ")
            } else {
                first = false
            }

            try _writeArgument(argument)
        }

        buffer.append("\n")
    }

    private mutating func _writeCommand(_ command: DKMCommand) throws {
        buffer.append("/")
        buffer.append(command.rawValue)
        buffer.append("\n")
    }

    private mutating func _writeEntry(_ entry: DKMEntry) throws {
        switch entry.command {
        case .comment:
            buffer.append("!")  // no newline unless no arguments

            if entry.arguments.isEmpty {
                buffer.append("\n")
            }

        default:
            if previous != entry.command {
                previous = entry.command

                try _writeCommand(entry.command)
            }
        }

        try _writeArguments(entry.arguments)
    }
}
