import Foundation

struct DateHelper {
    static let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    static func getRequiredDates() -> (today: String, next15: String, past15: String) {
        let now = Date()
        let calendar = Calendar.current
        
        let next15Date = calendar.date(byAdding: .day, value: 15, to: now)!
        let past15Date = calendar.date(byAdding: .day, value: -15, to: now)!
        
        return (
            today: formatter.string(from: now),
            next15: formatter.string(from: next15Date),
            past15: formatter.string(from: past15Date)
        )
    }
}
