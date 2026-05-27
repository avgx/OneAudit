import Foundation

public struct NodeRef: Decodable, Sendable, Equatable {
    public let name: String
    public let friendly_name: String?
}
