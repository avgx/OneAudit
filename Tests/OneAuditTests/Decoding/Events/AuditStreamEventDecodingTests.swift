import Foundation
import Testing
@testable import OneAudit

@Suite("AuditStreamEvent decoding")
struct AuditStreamEventDecodingTests {
    @Test("decodes stream event json")
    func decodeJson() throws {
        let json = """
        {"guid":"g1","timestamp":"20191004T114739","operation":13,"ip_address":"10.0.0.1"}
        """
        let decoded = try JSONDecoder().decode(AuditStreamEvent.self, from: Data(json.utf8))
        #expect(decoded.guid == "g1")
        #expect(decoded.operation.rawValue == 13)
        #expect(decoded.ip_address == "10.0.0.1")
    }
}
