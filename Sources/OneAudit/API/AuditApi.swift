import Foundation
import OneWireFormat
import RequestResponse

/// Audit API (`Audit.proto` inject + legacy Next web journal).
public enum AuditApi {
    // MARK: - Inject (`AuditEventInjector`)

    public static func injectCameraViewingEvent(cameraAp: AccessPoint) -> Request<Void> {
        let body = InjectCameraViewingEventRequest(camera_ap: cameraAp)
        return Request(
            path: "v1/audit/injectCameraViewingEvent",
            method: .post,
            body: body,
            id: "injectCameraViewingEvent"
        )
    }

    public static func injectArchiveViewingEvent(
        cameraAp: AccessPoint,
        archiveAp: AccessPoint
    ) -> Request<Void> {
        let body = InjectArchiveViewingEventRequest(camera_ap: cameraAp, archive_ap: archiveAp)
        return Request(
            path: "v1/audit/injectArchiveViewingEvent",
            method: .post,
            body: body,
            id: "injectArchiveViewingEvent"
        )
    }

    public static func injectPtzControlEvent(cameraAp: AccessPoint) -> Request<Void> {
        let body = InjectPtzControlEventRequest(camera_ap: cameraAp)
        return Request(
            path: "v1/audit/injectPtzControlEvent",
            method: .post,
            body: body,
            id: "injectPtzControlEvent"
        )
    }
}
