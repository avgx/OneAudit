import Foundation

/// `InjectPtzControlEventRequest` in `Audit.proto`.
public struct InjectPtzControlEventRequest: Encodable, Sendable, Equatable {
    public let camera_ap: AccessPoint

    public init(camera_ap: AccessPoint) {
        self.camera_ap = camera_ap
    }
}
