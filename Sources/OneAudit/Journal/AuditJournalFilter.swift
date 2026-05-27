import Foundation

public struct AuditJournalFilter: Sendable, Equatable {
    public var begin: Date
    public var end: Date
    public var eventTypes: [AuditEventType]

    public init(begin: Date, end: Date, eventTypes: [AuditEventType] = []) {
        self.begin = begin
        self.end = end
        self.eventTypes = eventTypes
    }
}
