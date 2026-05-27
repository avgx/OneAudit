import Foundation
import SafeEnum

/// Single audit journal row from legacy `GET audit/...` JSON.
public struct AuditJournalEntry: Decodable, Sendable, Identifiable, Equatable {
    public let data: AuditJournalEntryData
    public let eventType: AuditEventTypeValue
    public let timestamp: String

    public var id: String {
        "\(eventType.rawValue)-\(timestamp)-\(data.host ?? "")"
    }
}

@available(*, deprecated, renamed: "AuditJournalEntry")
public typealias AuditEvent = AuditJournalEntry
