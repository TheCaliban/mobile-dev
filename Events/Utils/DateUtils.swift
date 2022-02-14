import Foundation

class DateUtils {
    private static let dateFormatter = DateFormatter()
    
    
    /// Get a Date from a stringified Date
    /// - Parameter from: input string Date
    /// - Returns: Date object created from the String
    static func dateFromString(from: String) -> Date {
        return dateFormatter.date(from: from) ?? Date()
    }
    
    
    /// Truncate a Date to a Day format
    /// - Parameter from: input Date to truncated
    /// - Returns: truncated Date obj
    static func dayOnlyDateFromDate(from: Date) -> Date {
        return DateUtils.dateFromString(from: DateUtils.dayStringFromDate(from: from))
    }
    
    
    /// Get a stringified Date
    /// - Parameter from: input Date
    /// - Returns: stringified Date
    static func dayStringFromDate(from: Date) -> String {
        return String(
            DateUtils
                .formattedStringFromDate(from: from)
                .split(separator: "T")[0]
        )
    }
    
    
    /// Stringify a Date to a set format
    /// - Parameter from: input Date
    /// - Returns: formated stringified Date
    static func formattedStringFromDate(from: Date) -> String {
        DateUtils.dateFormatter.dateStyle = .medium
        DateUtils.dateFormatter.timeStyle = .none
        DateUtils.dateFormatter.locale = Locale(identifier: "en_US")
        
        return DateUtils.dateFormatter.string(from: from)
    }
    
    
    /// Sort an Array of Date with a given order
    /// - Parameters:
    ///   - from: array of Date to sort
    ///   - descending: order of the sort
    /// - Returns: A sorted Array of Date
    static func sortedDateArray(from: [Date], descending: Bool = true) -> [Date] {
        return from
            .map { DateUtils.formattedStringFromDate(from: $0) }
            .sorted { descending ? $0 < $1 : $1 < $0 }
            .map { DateUtils.dateFromString(from: $0) }
    }
}
