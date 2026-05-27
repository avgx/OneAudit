import Foundation
import OneWireFormat
import RequestResponse

/// Audit API (`Audit.proto` inject + legacy Next web journal).
public enum AuditApi {
    // MARK: - Journal (legacy Next web server)

    /// `GET audit/{host}/{endTime}/{beginTime}?filter=...`
    public static func listJournal(
        host: String,
        filter: AuditJournalFilter
    ) -> Request<AuditJournalResponse> {
        listJournal(
            host: host,
            endTime: Timestamp.utc.string(from: filter.end),
            beginTime: Timestamp.utc.string(from: filter.begin),
            filter: AuditEventType.filterQuery(filter.eventTypes)
        )
    }

    /// Low-level journal request with wire timestamp strings.
    public static func listJournal(
        host: String,
        endTime: String,
        beginTime: String,
        filter: String = ""
    ) -> Request<AuditJournalResponse> {
        var query: [(String, String?)] = []
        if !filter.isEmpty {
            query.append(("filter", filter))
        }
        return Request(
            path: "audit/\(host)/\(endTime)/\(beginTime)",
            method: .get,
            query: query,
            headers: ["Accept": "application/json"]
        )
    }

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
