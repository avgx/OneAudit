import Foundation

public extension AuditEventType {
    func localizedTemplate(bundle: Bundle? = nil) -> String? {
        let bundle = bundle ?? Bundle.module
        let keys = [localizationKey, legacyLocalizationKey]
        for key in keys {
            let value = AuditLocalization.localizedString(key, bundle: bundle, value: key)
            if value != key {
                return value
            }
        }
        return nil
    }

    var filterTitle: String {
        guard let template = localizedTemplate() else {
            return debugLabel
        }
        return AuditJournalFormatter.emptyTemplate(template)
    }
}

public extension AuditJournalEntry {
    func displayText(bundle: Bundle? = nil) -> String {
        let bundle = bundle ?? Bundle.module
        if let known = eventType.value,
           let template = known.localizedTemplate(bundle: bundle) {
            return AuditJournalFormatter.substitute(template: template, entry: self, bundle: bundle)
        }
        if let template = localizedTemplateForRawType(bundle: bundle) {
            return AuditJournalFormatter.substitute(template: template, entry: self, bundle: bundle)
        }
        return AuditJournalFormatter.fallbackDescription(for: self)
    }

    private func localizedTemplateForRawType(bundle: Bundle) -> String? {
        let legacyName = "AuditJournalMessage_type_\(eventType.rawValue)"
        let legacy = AuditLocalization.localizedString(legacyName, bundle: bundle, value: legacyName)
        if legacy != legacyName {
            return legacy
        }
        return nil
    }
}
