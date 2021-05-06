
import Foundation

// MARK: Manager for formatting data properly for display and transmission
struct FormatManager {
    
    // Get a string for a distance
    static func getDistance(distance: Double) -> String {
        return String(format: "%.2f", arguments: [distance]) + " km"
    }
    
    // Get a string for the elapsed time
    static func getStopWatchTime(elapsedSeconds: Int) -> String {
        let seconds = elapsedSeconds % 60
        let minutes = elapsedSeconds % 3600 / 60
        let hours = elapsedSeconds / 3600
        
        if hours == 0 {
            return String(format: "%02d:%02d",arguments: [minutes, seconds])
        }
        
        return String(format: "%02d:%02d:%02d",arguments: [hours, minutes, seconds])
    }
    
    // Get a pretty date string
    static func getLocalDateString(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy - h:mm aa"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: getLocalDate(time: time))
    }
    
    // Convert an ISO string to a Swift Date
    static func getLocalDate(time: String) -> Date {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormatter.date(from: time)!
    }
    
    // Get a detailed description for the hike
    static func getDayDescription(date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let weekday = calendar.dateComponents([.weekday], from: date).weekday!
        let hour = calendar.dateComponents([.hour], from: date).hour!
        let weekdayString = getWeekdayString(weekday: weekday)
        let timeOfDayString = getTimeOfDayString(hour: hour)
        return "\(weekdayString) \(timeOfDayString) Hike"
    }
    
    // Get a string for the day of the week
    static private func getWeekdayString(weekday: Int) -> String {
        switch weekday {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
    
    // Get a string for the time of day
    static private func getTimeOfDayString(hour: Int) -> String{
        if hour < 12 {
            return "Morning"
        } else if hour < 18 {
            return "Afternoon"
        } else {
            return "Evening"
        }
    }
}
