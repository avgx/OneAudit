import Foundation

public struct AuditJournalDayGroup: Sendable, Equatable {
    public let day: Date
    public let dayLabel: String
    public let entries: [AuditJournalEntry]
}

public enum AuditJournalGrouping {
    public static func byDay(
        _ entries: [AuditJournalEntry],
        calendar: Calendar = .current,
        locale: Locale = .current
    ) -> [AuditJournalDayGroup] {
        let dayFormatter = DateFormatter()
        dayFormatter.calendar = calendar
        dayFormatter.locale = locale
        dayFormatter.dateStyle = .short
        dayFormatter.timeStyle = .none

        let grouped = Dictionary(grouping: entries) { entry -> Date in
            guard let date = entry.parsedTimestamp else {
                return calendar.startOfDay(for: .distantPast)
            }
            return calendar.startOfDay(for: date)
        }

        return grouped
            .map { day, dayEntries in
                AuditJournalDayGroup(
                    day: day,
                    dayLabel: dayFormatter.string(from: day),
                    entries: dayEntries.sorted { lhs, rhs in
                        (lhs.parsedTimestamp ?? .distantPast) > (rhs.parsedTimestamp ?? .distantPast)
                    }
                )
            }
            .sorted { $0.day > $1.day }
    }
}
