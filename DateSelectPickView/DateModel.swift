//
//  DateModel.swift
//  Pods
//
//  Created by Mr on 2017/9/4.
//
//

import UIKit

class DateModel: NSObject {
    var dateArray = Array<Any>()
    var hourArray = Array<Any>()
    var minuteArray = Array<Any>()
    
    func getDataSource(day: Int, hour: Int) {
        
        
        dateArray.removeAll()///30天

        var temDay = 3
        while temDay < 30 {
            let dateName = Date().dateByAddingDays(day: temDay)
            let weekName = Date().weekDayName(date: dateName)
            let monthDay = Date().getMonthAndDay(date: dateName)
            
            dateArray.append("\(monthDay)\(weekName)")
            temDay += 1
        }
        dateArray.insert("今天", at: 0)
        dateArray.insert("明天", at: 1)
        dateArray.insert("后天", at: 2)
        
        if day == 0 {
            
            var nowHour = Date().tt_hour
            let nowMinute = Date().tt_minute
            hourArray.removeAll()
            if nowMinute > 50 {
                nowHour += 1
            }
            while nowHour < 24 {
                hourArray.append("\(nowHour)点")
                nowHour += 1
            }
            
            if hour == 0 {
                if nowMinute < 10 {
                    minuteArray = ["10分","20分","30分","40分","50分"]
                }else if nowMinute < 20 {
                    minuteArray = ["20分","30分","40分","50分"]
                }else if nowMinute < 30 {
                    minuteArray = ["30分","40分","50分"]
                }else if nowMinute < 40 {
                    minuteArray = ["40分","50分"]
                }else if nowMinute < 50 {
                    minuteArray = ["50分"]
                }else
                {
                    minuteArray = ["0分","10分","20分","30分","40分","50分"]
                }
            }else
            {
                minuteArray = ["0分","10分","20分","30分","40分","50分"]
            }
            
            
            
        }else {
            hourArray = ["0点","1点","2点","3点","4点","5点","6点","7点","8点","9点","10点","11点","12点","13点","14点","15点","16点","17点","18点","19点","20点","21点","22点","23点"]
            minuteArray = ["0分","10分","20分","30分","40分","50分"]
        }
        
    }
    
    func removeLastStr(str: String) -> (String) {
        return str.substringTo(str.length - 1)
    }
    
    func getSelectDate(day: Int, hour: Int, minute: Int) -> (String) {
        let dayDate = Date().dateByAddingDays(day: day)
        let dayStr =  Date().getYearMonthDay(date: dayDate)
        let hourStr = removeLastStr(str: hourArray[hour] as! String)
        let minuteStr = removeLastStr(str: minuteArray[minute] as! String)
        return ("\(dayStr) \(hourStr) \(minuteStr)")
    }
    
}
