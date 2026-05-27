import Foundation

public struct ComponentRef: Decodable, Sendable, Equatable {
    public let access_point: AccessPoint
    public let friendly_name: String?
    public let group: String?
}
