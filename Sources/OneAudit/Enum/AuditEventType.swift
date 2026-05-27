import Foundation
import SafeEnum

/// Audit journal / stream operation type (`AuditEvent.EAuditEventType` in `Events.proto`).
public enum AuditEventType: Int, Codable, Hashable, Sendable, CaseIterable {
    // Stale journal markers (legacy `SE_*`, still used in filters)
    case SE_SYSTEM_TIMESTAMP = 0
    case SE_CLEANUP = 1
    case SE_BEGIN_VIOLATION = 2
    case SE_END_VIOLATION = 3
    case SE_SEQUENCE_VIOLATION = 4
    case SE_DATA_VIOLATION = 5
    case SE_ACTIVITY_PAUSE = 6

    case AE_USER_ADD = 7
    case AE_USER_REMOVE = 8
    case AE_USER_SETUP = 9
    case AE_ROLE_ADD = 10
    case AE_ROLE_REMOVE = 11
    case AE_ROLE_SETUP = 12
    case AE_USER_LOGIN = 13
    case AE_USER_LOGOUT = 14
    case AE_DEVICE_ADD = 15
    case AE_DEVICE_REMOVE = 16
    case AE_DEVICE_SETUP = 17
    case AE_DETECTOR_ADD = 18
    case AE_DETECTOR_REMOVE = 19
    case AE_DETECTOR_SETUP = 20
    case AE_ARCHIVE_ADD = 21
    case AE_ARCHIVE_REMOVE = 22
    case AE_ARCHIVE_SETUP = 23
    case AE_RULE_ADD = 24
    case AE_RULE_REMOVE = 25
    case AE_RULE_SETUP = 26
    case AE_ALERT_MODE_SETUP = 27
    case AE_ZONE_ARMED = 28
    case AE_ZONE_DISARMED = 29
    case AE_MMEXPORT = 30
    case AE_NOTIFIER_ADD = 31
    case AE_NOTIFIER_REMOVE = 32
    case AE_NOTIFIER_SETUP = 33
    case AE_GENERAL_SETUP = 34
    case AE_ARCHIVE_BINDING_SETUP = 35
    case AE_MMEXPORT_ADD = 36
    case AE_MMEXPORT_REMOVE = 37
    case AE_MMEXPORT_SETUP = 38
    case AE_MACRO_ADD = 39
    case AE_MACRO_REMOVE = 40
    case AE_MACRO_SETUP = 41
    case AE_ALERT_TAKING = 42
    case AE_ALERT_DANGEROUS = 43
    case AE_ALERT_SUSPICIOUS = 44
    case AE_ALERT_FALSE = 45
    /// Legacy client id; reserved in current `Events.proto`.
    case AE_ALERT_MISSED = 46
    case AE_NODE_INCLUDED = 47
    case AE_NODE_EXCLUDED = 48
    case AE_ARCHIVE_VIEWING = 49
    case AE_CAMERA_VIEWING = 50
    case AE_LAYOUT_VIEWING = 51
    /// Legacy client ids; reserved in current `Events.proto`.
    case AE_ARCHIVE_SMART_SEARCH = 52
    case AE_ARCHIVE_GROUP_FACE_SEARCH = 53
    case AE_ARCHIVE_GROUP_VEHICLE_PLATE_SEARCH = 54
    case AE_JOURNAL_EXPORT = 55
    case AE_LDAP_ADD = 56
    case AE_LDAP_REMOVE = 57
    case AE_LDAP_SETUP = 58
    case AE_LAYOUT_ADD = 59
    case AE_LAYOUT_REMOVE = 60
    case AE_LAYOUT_SETUP = 61
    case AE_USER_LOGIN_FAILED = 62
    case AE_PTZ_CONTROL = 63
    case AE_ARCHIVE_COMMENT_ADD = 64
    case AE_ARCHIVE_COMMENT_EDIT = 65
    /// Legacy client ids; reserved band in current `Events.proto`.
    case AE_LICENSE_EXPIRED = 66
    case AE_LOGOUT_ON_IDLE = 67
    case AE_LOCK_ON_IDLE = 68
    case AE_UNLOCK_ON_IDLE = 69
    case AE_LOCK_BY_USER = 70
    case AE_USER_SESSION_EXPIRED = 71

    case AE_COUNTER_ADD = 74
    case AE_COUNTER_REMOVE = 75
    case AE_COUNTER_SETUP = 76
    case AE_ALERT_POSTPONE = 77
    case AE_REVISION_RESET = 78
    case AE_BACKUP_APPLIED = 79
    case AE_ARCHIVE_REPLICATION_SETUP = 80
    case AE_TEMPLATE_BINDING = 81
    case AE_TEMPLATE_UNBINDING = 82
    case AE_INCLUDE_CAMERA_IN_GROUP = 83
    case AE_EXCLUDE_CAMERA_FROM_GROUP = 84
    case AE_ARCHIVE_INTERVAL_REMOVE = 85
    case AE_BOOKMARK_ADDED = 86
    case AE_BOOKMARK_CHANGED = 87
    case AE_BOOKMARK_REMOVED = 88
    case AE_BOOKMARK_EXPORTED = 89
    case AE_LDAP_SYNCHRONIZATION_STARTED = 90
    case AE_LDAP_SYNCHRONIZATION_STOPPED = 91
    case AE_USER_ROLE_ASSIGNMENT_ADDED = 92
    case AE_USER_ROLE_ASSIGNMENT_REMOVED = 93
    case AE_DEVICE_RESET = 94
    case AE_INCLUDE_COMPONENT_IN_GROUP = 95
    case AE_EXCLUDE_COMPONENT_FROM_GROUP = 96
    case AE_SYSTEM_JOURNAL_RETENTION_PERIOD_SETUP = 97
    case AE_SYSTEM_JOURNAL_CLEANUP_PERIOD_SETUP = 98
}

public typealias AuditEventTypeValue = SafeEnum<AuditEventType>

public extension AuditEventType {
    /// Stable modern String Catalog key (`audit.event.aeUserLogin`).
    var localizationKey: String {
        "audit.event.\(camelCaseName)"
    }

    /// Legacy key used in migrated `Localizable.xcstrings` (`AuditJournalMessage_AE_USER_LOGIN`).
    var legacyLocalizationKey: String {
        "AuditJournalMessage_\(String(describing: self))"
    }

    var debugLabel: String {
        String(describing: self)
            .replacingOccurrences(of: "AE_", with: "")
            .replacingOccurrences(of: "SE_", with: "")
            .replacingOccurrences(of: "_", with: " ")
    }

    /// Cases shown in audit event filter UI (matches former `AuditJournalMessage.allCases` coverage).
    static var filterCases: [AuditEventType] {
        allCases
    }

    /// Builds `?filter=7,13,50` query value.
    static func filterQuery(_ types: [AuditEventType]) -> String {
        types.map(\.rawValue.description).joined(separator: ",")
    }

    static func filterQuery(_ values: [AuditEventTypeValue]) -> String {
        values.map(\.rawValue.description).joined(separator: ",")
    }
}

private extension AuditEventType {
    var camelCaseName: String {
        let name = String(describing: self)
        let parts = name.split(separator: "_").map(String.init)
        guard let first = parts.first else { return name.lowercased() }
        return ([first.lowercased()] + parts.dropFirst().map { $0.capitalized }).joined()
    }
}
