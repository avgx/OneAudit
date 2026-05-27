import Foundation

enum AuditJournalFormatter {
    static func emptyTemplate(_ template: String) -> String {
        template
            .replacingOccurrences(of: "{host}", with: "")
            .replacingOccurrences(of: "{ip_address}", with: "")
            .replacingOccurrences(of: "{mac_address}", with: "")
            .replacingOccurrences(of: "{role}", with: "")
            .replacingOccurrences(of: "{user}", with: "")
            .replacingOccurrences(of: "{archive}", with: "")
            .replacingOccurrences(of: "{device}", with: "")
            .replacingOccurrences(of: "{detector}", with: "")
            .replacingOccurrences(of: "{autoRule}", with: "")
            .replacingOccurrences(of: "{component}", with: "")
            .replacingOccurrences(of: "{componentType}", with: "")
            .replacingOccurrences(of: "{property}", with: "")
            .replacingOccurrences(of: "{setting}", with: "")
            .replacingOccurrences(of: "{value}", with: "")
            .replacingOccurrences(of: "{macro}", with: "")
            .replacingOccurrences(of: "{modifier}", with: "")
            .replacingOccurrences(of: "{layout}", with: "")
            .replacingOccurrences(of: "{obj_role}", with: "")
            .replacingOccurrences(of: "{obj_user}", with: "")
            .replacingOccurrences(of: "{notifier}", with: "")
            .replacingOccurrences(of: "{detectorEngine}", with: "")
            .replacingOccurrences(of: "{domain}", with: "")
            .replacingOccurrences(of: "{start}", with: "")
            .replacingOccurrences(of: "{end}", with: "")
            .replacingOccurrences(of: "{search}", with: "")
            .replacingOccurrences(of: "{server}", with: "")
            .replacingOccurrences(of: "{camera}", with: "")
            .replacingOccurrences(of: "AE_", with: "")
            .replacingOccurrences(of: "SE_", with: "")
            .replacingOccurrences(of: "AuditJournalMessage_", with: "")
            .replacingOccurrences(of: "AUDITJOURNALMESSAGE_", with: "")
            .replacingOccurrences(of: "_", with: " ")
    }

    static func substitute(
        template: String,
        entry: AuditJournalEntry,
        bundle: Bundle? = nil
    ) -> String {
        let bundle = bundle ?? Bundle.module
        var result = template
        let data = entry.data

        if let host = data.host {
            result = result.replacingOccurrences(of: "{host}", with: host)
        }
        if let ip_address = data.ip_address {
            result = result.replacingOccurrences(of: "{ip_address}", with: ip_address)
        }
        if let mac_address = data.mac_address {
            result = result.replacingOccurrences(of: "{mac_address}", with: mac_address)
        }
        if let role = data.role {
            result = result.replacingOccurrences(of: "{role}", with: role)
        }
        if let user = data.user {
            result = result.replacingOccurrences(of: "{user}", with: user)
        }
        if let archive = data.archive {
            result = result.replacingOccurrences(of: "{archive}", with: archive)
        }
        if let device = data.device {
            result = result.replacingOccurrences(of: "{device}", with: device)
        }
        if let detector = data.detector {
            result = result.replacingOccurrences(of: "{detector}", with: detector)
        }
        if let autoRule = data.autoRule {
            result = result.replacingOccurrences(of: "{autoRule}", with: autoRule)
        }
        if let component = data.component {
            result = result.replacingOccurrences(of: "{component}", with: component)
        }
        if let componentType = data.componentType {
            result = result.replacingOccurrences(of: "{componentType}", with: componentType)
        }
        if let property = data.property {
            result = result.replacingOccurrences(
                of: "{property}",
                with: AuditLocalization.localizeRawValue(property, bundle: bundle)
            )
        }
        if let setting = data.setting {
            result = result.replacingOccurrences(
                of: "{setting}",
                with: AuditLocalization.localizeRawValue(setting, bundle: bundle)
            )
        }
        if let value = data.value {
            if data.property == "Password" || data.setting == "Password" {
                result = result.replacingOccurrences(of: "{value}", with: "*****")
            } else {
                result = result.replacingOccurrences(
                    of: "{value}",
                    with: AuditLocalization.localizeRawValue(value, bundle: bundle)
                )
            }
        }
        if let macro = data.macro {
            result = result.replacingOccurrences(of: "{macro}", with: macro)
        }
        if let modifier = data.modifier {
            result = result.replacingOccurrences(of: "{modifier}", with: modifier)
        }
        if let layout = data.layout {
            result = result.replacingOccurrences(of: "{layout}", with: layout)
        }
        if let obj_role = data.obj_role {
            result = result.replacingOccurrences(of: "{obj_role}", with: obj_role)
        }
        if let obj_user = data.obj_user {
            result = result.replacingOccurrences(of: "{obj_user}", with: obj_user)
        }
        if let notifier = data.notifier {
            result = result.replacingOccurrences(of: "{notifier}", with: notifier)
        }
        if let detectorEngine = data.detectorEngine {
            result = result.replacingOccurrences(of: "{detectorEngine}", with: detectorEngine)
        }
        if let domain = data.domain {
            result = result.replacingOccurrences(of: "{domain}", with: domain)
        }
        if let start = data.start {
            result = result.replacingOccurrences(of: "{start}", with: start)
        }
        if let end = data.end {
            result = result.replacingOccurrences(of: "{end}", with: end)
        }
        if let search = data.search {
            result = result.replacingOccurrences(of: "{search}", with: search)
        }
        if let server = data.server {
            result = result.replacingOccurrences(of: "{server}", with: server)
        }
        if let camera = data.camera {
            result = result.replacingOccurrences(of: "{camera}", with: camera)
        }
        return result
    }

    static func fallbackDescription(for entry: AuditJournalEntry) -> String {
        let typeLabel = entry.eventType.value?.debugLabel ?? "type \(entry.eventType.rawValue)"
        var lines = [typeLabel, entry.timestamp]
        let data = entry.data
        if let host = data.host { lines.append("host: \(host)") }
        if let role = data.role, let user = data.user { lines.append("\(role)/\(user)") }
        if let device = data.device { lines.append("device: \(device)") }
        return lines.joined(separator: "\n")
    }
}
