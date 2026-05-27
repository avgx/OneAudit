import Foundation
import RequestResponse
import Testing
@testable import OneAudit

@Suite("AuditApi request builders")
struct AuditApiTests {
    @Test("listJournal builds path and filter query")
    func listJournal_query() {
        let begin = Date(timeIntervalSince1970: 1_569_588_000)
        let end = Date(timeIntervalSince1970: 1_569_674_000)
        let filter = AuditJournalFilter(
            begin: begin,
            end: end,
            eventTypes: [.AE_USER_LOGIN, .AE_DEVICE_ADD]
        )
        let request = AuditApi.listJournal(host: "HOST-1", filter: filter)
        #expect(request.method == .get)
        #expect(request.path.contains("HOST-1"))
        #expect(request.query?.contains(where: { $0.0 == "filter" && $0.1 == "13,15" }) == true)
    }

    @Test("inject camera viewing posts body")
    func injectCameraViewing() {
        let cameraAp = "hosts/SERVER/DeviceIpint.1/SourceEndpoint.video:0:0"
        let request = AuditApi.injectCameraViewingEvent(cameraAp: cameraAp)
        #expect(request.path == "v1/audit/injectCameraViewingEvent")
        #expect(request.method == .post)
        let body = request.body as? InjectCameraViewingEventRequest
        #expect(body?.camera_ap == cameraAp)
    }
}
