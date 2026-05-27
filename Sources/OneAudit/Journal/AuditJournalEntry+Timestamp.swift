import Foundation
import OneWireFormat

public extension AuditJournalEntry {
    var parsedTimestamp: Date? {
        Timestamp.utc.date(from: timestamp)
    }

    func timeLabel(
        dateStyle: DateFormatter.Style = .none,
        timeStyle: DateFormatter.Style = .medium,
        locale: Locale = .current
    ) -> String? {
        guard let date = parsedTimestamp else { return nil }
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: date)
    }
}
