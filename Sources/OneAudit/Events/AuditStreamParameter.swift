import Foundation

public struct AuditStreamParameter: Decodable, Sendable, Equatable {
    public let group: String?
    public let name: String?
    public let value: String?
}
