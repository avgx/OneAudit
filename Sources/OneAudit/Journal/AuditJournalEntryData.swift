import Foundation

/// Flat journal payload (`data` in legacy audit JSON).
public struct AuditJournalEntryData: Decodable, Sendable, Equatable {
    public let host: String?
    public let ip_address: String?
    public let mac_address: String?
    public let role: String?
    public let user: String?
    public let archive: String?
    public let device: String?
    public let detector: String?
    public let autoRule: String?
    public let component: String?
    public let componentType: String?
    public let property: String?
    public let setting: String?
    public let value: String?
    public let macro: String?
    public let modifier: String?
    public let layout: String?
    public let obj_role: String?
    public let obj_user: String?
    public let notifier: String?
    public let detectorEngine: String?
    public let domain: String?
    public let start: String?
    public let end: String?
    public let search: String?
    public let server: String?
    public let camera: String?
    public let lexems: String?
}
