import Foundation
import SafeEnum

/// `AuditEvent` in `Events.proto` (`ET_Audit = 33`).
public struct AuditStreamEvent: Decodable, Sendable, Equatable {
    public let guid: String?
    public let timestamp: String?
    public let operation: AuditEventTypeValue
    public let node_info: NodeRef?
    public let user: AuditStreamUserInfo?
    public let ip_address: String?
    public let components: [ComponentRef]?
    public let macro: MacroRef?
    public let params: [AuditStreamParameter]?
}
