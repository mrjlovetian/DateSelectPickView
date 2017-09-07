//
//  DateNearby.swift
//  Pods
//
//  Created by Mr on 2017/9/4.
//
//

import Foundation
import UIKit

extension Date{
    /// EZSE: Initializes Date from string and format
//    public init?(fromString string: String, format: String) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = format
//        if let date = formatter.date(from: string) {
//            self = date
//        } else {
//            return nil
//        }
//    }
    
    func weekDayName(date: Date) -> (String) {
        let weekday = Calendar.current.component(.weekday, from: date)
        
        var tempStr = "";
        if(weekday == 1)
        {
            tempStr = "周一"
        }
        if(weekday == 2)
        {
            tempStr = "周二"
            
        }
        if(weekday == 3)
        {
            tempStr = "周三"
            
        }
        if(weekday == 4)
        {
            tempStr = "周四"
            
        }
        if(weekday == 5)
        {
            tempStr = "周五"
            
        }
        if(weekday == 6)
        {
            tempStr = "周六"
            
        }
        if(weekday == 7)
        {
            tempStr = "周日"
            
        }
        
        return tempStr;
    }
    
    public func getYearMonthDay(date: Date) -> (String) {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: date)
    }
    
    func dateByAddingDays(day: Int) -> (Date) {
        let timeInterval = Int(self.timeIntervalSinceReferenceDate) + 86400 * day
        let date = Date.init(timeIntervalSinceReferenceDate: TimeInterval(timeInterval))
        return date
    }
    
    func getMonthAndDay(date: Date) -> (String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM月dd日"
        return dateFormatter.string(from: date)
    }
}
