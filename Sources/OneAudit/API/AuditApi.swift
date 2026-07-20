import Foundation
import OneWireFormat
import RequestResponse

/// Native BL audit inject API (`Audit.proto` / `AuditEventInjector`).
///
/// Read audit history via OneEventHistory (`ET_Audit` / `ReadEvents`), not this package.
public enum AuditApi {
    /// Endpoint: `POST /v1/audit/injectCameraViewingEvent`
    public static func injectCameraViewingEvent(cameraAp: AccessPoint) -> Request<Void> {
        Request(
            path: "v1/audit/injectCameraViewingEvent",
            method: .post,
            body: InjectCameraViewingEventRequest(camera_ap: cameraAp),
            id: "injectCameraViewingEvent"
        )
    }

    /// Endpoint: `POST /v1/audit/injectArchiveViewingEvent`
    public static func injectArchiveViewingEvent(
        cameraAp: AccessPoint,
        archiveAp: AccessPoint
    ) -> Request<Void> {
        Request(
            path: "v1/audit/injectArchiveViewingEvent",
            method: .post,
            body: InjectArchiveViewingEventRequest(camera_ap: cameraAp, archive_ap: archiveAp),
            id: "injectArchiveViewingEvent"
        )
    }

    /// Endpoint: `POST /v1/audit/injectPtzControlEvent`
    public static func injectPtzControlEvent(cameraAp: AccessPoint) -> Request<Void> {
        Request(
            path: "v1/audit/injectPtzControlEvent",
            method: .post,
            body: InjectPtzControlEventRequest(camera_ap: cameraAp),
            id: "injectPtzControlEvent"
        )
    }
}
