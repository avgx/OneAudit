import Foundation

/// `InjectArchiveViewingEventRequest` in `Audit.proto`.
public struct InjectArchiveViewingEventRequest: Encodable, Sendable, Equatable {
    public let camera_ap: AccessPoint
    public let archive_ap: AccessPoint

    public init(camera_ap: AccessPoint, archive_ap: AccessPoint) {
        self.camera_ap = camera_ap
        self.archive_ap = archive_ap
    }
}
