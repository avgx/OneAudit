import Foundation

public struct MacroRef: Decodable, Sendable, Equatable {
    public let guid: String
    public let friendly_name: String?
}
