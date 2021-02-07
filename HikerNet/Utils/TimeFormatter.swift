
import Foundation

struct TimeFormatter {
    static func getStopWatchTime(elapsedSeconds: Int) -> String {
        let seconds = elapsedSeconds % 60
        let minutes = elapsedSeconds % 3600 / 60
        let hours = elapsedSeconds / 3600
        
        if hours == 0 {
            return String(format: "%02d:%02d",arguments: [minutes, seconds])
        }
        
        return String(format: "%02d:%02d:%02d",arguments: [hours, minutes, seconds])
    }
    
    static func getLocalDateString(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy - h:mm aa"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: getLocalDate(time: time))
    }
    
    static func getLocalDate(time: String) -> Date {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormatter.date(from: time)!
    }
    
    static func getDayDescription(date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let weekday = calendar.dateComponents([.weekday], from: date).weekday!
        let hour = calendar.dateComponents([.hour], from: date).hour!
        let weekdayString = getWeekdayString(weekday: weekday)
        let timeOfDayString = getTimeOfDayString(hour: hour)
        return "\(weekdayString) \(timeOfDayString) Hike"
    }
    
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
    
    static private func getTimeOfDayString(hour: Int) -> String{
        if hour < 12 {
            return "Morning"
        } else if hour < 18 {
            return "Afternoon"
        } else if hour < 24 {
            return "Evening"
        } else {
            return ""
        }
    }
}
