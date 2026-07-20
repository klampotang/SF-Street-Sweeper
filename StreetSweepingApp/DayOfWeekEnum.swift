//
//  DayOfWeekEnum.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//

enum DayOfWeek: Int, CaseIterable, Identifiable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var id: Int { self.rawValue }
    
    var name: String {
        switch self {
        case .sunday: return "Sunday"
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        }
    }
    
    var apiDayString: String {
        switch self {
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tues"
        case .wednesday: return "Wed"
        case .thursday: return "Thurs"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        }
    }
}
