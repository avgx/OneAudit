import Foundation
import Testing
@testable import OneAudit

@Suite("Audit localization")
struct AuditLocalizationTests {
    @Test("displayText for login event is non-empty")
    func loginDisplayText() throws {
        let data = try FixtureLoader.loadData(resource: "audit", ext: "json")
        let response = try JSONDecoder().decode(AuditJournalResponse.self, from: data)
        let login = try #require(response.events.first(where: { $0.eventType.rawValue == 13 }))
        let text = login.displayText()
        #expect(text.isEmpty == false)
        #expect(text.contains("root") || text.contains("admin") || text.contains("LENOVO"))
    }

    @Test("filterTitle for known type is non-empty")
    func filterTitle() {
        let title = AuditEventType.AE_USER_LOGIN.filterTitle
        #expect(title.isEmpty == false)
    }
}
