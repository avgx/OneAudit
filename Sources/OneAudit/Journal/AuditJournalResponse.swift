import Foundation

public struct AuditJournalResponse: Decodable, Sendable, Equatable {
    public let events: [AuditJournalEntry]
}

@available(*, deprecated, renamed: "AuditJournalResponse")
public typealias AuditResponse = AuditJournalResponse
