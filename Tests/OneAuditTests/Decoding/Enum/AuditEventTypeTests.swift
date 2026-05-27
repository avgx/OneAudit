import Testing
@testable import OneAudit

@Suite("AuditEventType")
struct AuditEventTypeTests {
    @Test("filterQuery joins raw values")
    func filterQuery() {
        let query = AuditEventType.filterQuery([.AE_USER_LOGIN, .AE_DEVICE_ADD])
        #expect(query == "13,15")
    }

    @Test("unknown raw value decodes as SafeEnum nil value")
    func unknownValue() {
        let value = AuditEventTypeValue(rawValue: 999)
        #expect(value.value == nil)
        #expect(value.rawValue == 999)
    }
}
