import Foundation
import RequestResponse
import Testing
@testable import OneAudit

@Suite("AuditApi request builders")
struct AuditApiTests {
    @Test("injectCameraViewingEvent posts v1 body")
    func injectCameraViewing() {
        let cameraAp = "hosts/SERVER/DeviceIpint.1/SourceEndpoint.video:0:0"
        let request = AuditApi.injectCameraViewingEvent(cameraAp: cameraAp)
        #expect(request.path == "v1/audit/injectCameraViewingEvent")
        #expect(request.method == .post)
        let body = request.body as? InjectCameraViewingEventRequest
        #expect(body?.camera_ap == cameraAp)
    }

    @Test("injectArchiveViewingEvent posts camera and archive")
    func injectArchiveViewing() {
        let cameraAp = "hosts/SERVER/DeviceIpint.1/SourceEndpoint.video:0:0"
        let archiveAp = "hosts/SERVER/MultimediaStorage.AliceBlue/MultimediaStorage"
        let request = AuditApi.injectArchiveViewingEvent(cameraAp: cameraAp, archiveAp: archiveAp)
        #expect(request.path == "v1/audit/injectArchiveViewingEvent")
        #expect(request.method == .post)
        let body = request.body as? InjectArchiveViewingEventRequest
        #expect(body?.camera_ap == cameraAp)
        #expect(body?.archive_ap == archiveAp)
    }

    @Test("injectPtzControlEvent posts v1 body")
    func injectPtzControl() {
        let cameraAp = "hosts/SERVER/DeviceIpint.1/SourceEndpoint.video:0:0"
        let request = AuditApi.injectPtzControlEvent(cameraAp: cameraAp)
        #expect(request.path == "v1/audit/injectPtzControlEvent")
        #expect(request.method == .post)
        let body = request.body as? InjectPtzControlEventRequest
        #expect(body?.camera_ap == cameraAp)
    }

    @Test("typed Request response markers")
    func typedRequestMarkers() {
        let _: Request<Void> = AuditApi.injectCameraViewingEvent(cameraAp: "hosts/X")
        let _: Request<Void> = AuditApi.injectArchiveViewingEvent(cameraAp: "hosts/X", archiveAp: "hosts/Y")
        let _: Request<Void> = AuditApi.injectPtzControlEvent(cameraAp: "hosts/X")
    }
}
