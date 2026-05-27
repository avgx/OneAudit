import Foundation

enum AuditLocalization {
    static func localizedString(
        _ key: String,
        bundle: Bundle? = nil,
        value: String? = nil
    ) -> String {
        let bundle = bundle ?? Bundle.module
        let fallback = value ?? key
        let result = NSLocalizedString(key, bundle: bundle, value: fallback, comment: "")
        return result == key ? fallback : result
    }

    static func localizeRawValue(_ raw: String, bundle: Bundle? = nil) -> String {
        let bundle = bundle ?? Bundle.module
        switch raw.lowercased() {
        case "yes", "true":
            if let value = lookup(["audit.boolean.true", "LocalizableBooleanTypeConverter_True"], bundle: bundle) {
                return value
            }
        case "no", "false":
            if let value = lookup(["audit.boolean.false", "LocalizableBooleanTypeConverter_False"], bundle: bundle) {
                return value
            }
        default:
            break
        }

        if let value = lookup(
            ["audit.property.\(raw)", raw, "FeatureAccessPropertyDescriptor_\(raw)"],
            bundle: bundle
        ) {
            return value
        }
        return raw
    }

    private static func lookup(_ keys: [String], bundle: Bundle) -> String? {
        for key in keys {
            let result = NSLocalizedString(key, bundle: bundle, value: key, comment: "")
            if result != key {
                return result
            }
        }
        return nil
    }
}
