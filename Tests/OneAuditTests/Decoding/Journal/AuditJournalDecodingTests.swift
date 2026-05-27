import Foundation
import Testing
@testable import OneAudit

@Suite("Audit journal decoding")
struct AuditJournalDecodingTests {
    @Test("decodes audit.json fixture")
    func decodeFixture() throws {
        let data = try FixtureLoader.loadData(resource: "audit", ext: "json")
        let response = try JSONDecoder().decode(AuditJournalResponse.self, from: data)
        #expect(response.events.isEmpty == false)
        #expect(response.events.contains(where: { $0.eventType.rawValue == 13 }))
    }

    @Test("parses journal timestamps via Timestamp.utc")
    func parseTimestamps() throws {
        let data = try FixtureLoader.loadData(resource: "audit", ext: "json")
        let response = try JSONDecoder().decode(AuditJournalResponse.self, from: data)
        let login = try #require(response.events.first(where: { $0.eventType.rawValue == 13 }))
        #expect(login.parsedTimestamp != nil)
        #expect(login.timeLabel() != nil)
    }
}
