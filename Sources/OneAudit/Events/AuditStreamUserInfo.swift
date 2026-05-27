import Foundation

public struct AuditStreamUserInfo: Decodable, Sendable, Equatable {
    public let name: String?
    public let friendly_name: String?
    public let role_name: String?
}
