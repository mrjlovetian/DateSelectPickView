//
//  String.swift
//  Topkber
//
//  Created by 张玺 on 15/12/2.
//  Copyright © 2015年 KaKao. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substringFrom(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    // 从几到几，包含关系
    func substringFrom(_ from: Int, to:Int) -> String {
        if self.length > 0 {
            let fromInde = self.characters.index(self.startIndex, offsetBy: from)
            let endIndex = self.characters.index(self.startIndex, offsetBy: to)
            let range = Range<String.Index>(fromInde..<endIndex)
            return self.substring(with: range)
        } else {
            return self
        }
        
    }
    // 从0到几，包含关系
    func substringTo(_ to: Int) -> String {
        if self.length > 0 {
            let fromInde = self.characters.index(self.startIndex, offsetBy: 0)
            let endIndex = self.characters.index(self.startIndex, offsetBy: to)
            let range = Range<String.Index>(fromInde..<endIndex)
            return self.substring(with: range)
        } else {
            return self
        }
        
    }
    // 计算label大小
    func boundingRectWithLabel(_ label: UILabel,width:CGFloat) -> CGRect {
        let size = CGSize(width: width, height: 1000)
        let attributes = [NSFontAttributeName:label.font]
        let str:NSString = self as NSString
        let result = str.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGRect(x: label.tt_x, y: label.tt_y, width: result.width, height: result.height)
    }
    
    // 返回2015年12月08日，输入格式YYYY-MM-dd HH:mm:ss
    func timeTransform() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        if date != nil {
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "MM"
            let month = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "dd"
            let day = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "HH"
            let hour = dateFormatter.string(from: date!)
            return year + "年" + month + "月" + day + "日" + hour + "时"
        }
        return ""
    }
    
    // 返回08-08，输入格式YYYY-MM-dd HH:mm:ss
    func timeTransformDay() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        if date != nil {
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "MM"
            let month = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "dd"
            let day = dateFormatter.string(from: date!)
            return month + "-" + day
        }
        return ""
    }
    
    //IM看房计划日期格式
    func seeHouseTimeTransform() ->String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        if date != nil {
            dateFormatter.dateFormat = "MM"
            let month = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "dd"
            let day = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "HH"
            let hour = dateFormatter.string(from: date!)
            dateFormatter.dateFormat = "mm"
            let minute = dateFormatter.string(from: date!)
            
            return month + "月" + day + "日" + hour + ":" + minute
        }
        return ""
    }
    
    // 返回14:30，输入格式YYYY-MM-dd HH:mm:ss
    func timeTransformForDayTime() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        if date != nil {
            dateFormatter.dateFormat = "HH:mm"
            let datTime = dateFormatter.string(from: date!)
            return datTime
        }
        return ""
    }
    
    // 返回2017.09，输入格式YYYY-MM-dd
    func timeTransformForLineView() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let date = dateFormatter.date(from: self)
        if date != nil {
            dateFormatter.dateFormat = "YYYY.MM"
            let datTime = dateFormatter.string(from: date!)
            return datTime
        }
        return ""
    }
    
    // 返回2017.09，输入格式YYYY-MM
    func timeChangeForLineView(space:Int) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM"
        var date = dateFormatter.date(from: self)
        
        let calendar = NSCalendar.current
        date = calendar.date(byAdding: Calendar.Component.month, value: -space, to: date!, wrappingComponents: false)
        
        
        if date != nil {
            dateFormatter.dateFormat = "YYYY.MM"
            let datTime = dateFormatter.string(from: date!)
            return datTime
        }
        return ""
    }
    
    /**
     * 计算指定时间与当前的时间差
     * @param compareDate   某一指定时间
     * @return 多少(秒or分or天or月or年)+前 (比如，2小时前、10分钟前)
     */
    func stringWithTimelineDate() ->String{
        // 1.创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        fmt.locale = NSLocale(localeIdentifier: "en") as Locale!
        
        // 2.将字符串时间,转成NSDate类型
        guard let createDate = fmt.date(from: self) else {
            return ""
        }
        
        // 3.创建当前时间
        let nowDate = NSDate()
        
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        // 5.对时间间隔处理
        // 5.1.显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2.59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        // 5.4.创建日历对象
        let calendar = NSCalendar.current
        
        // 5.3.11小时前
        if interval < 60 * 60 * 24 && !calendar.isDateInYesterday(createDate){
            fmt.dateFormat = "今天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        
        // 5.5.处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // 5.6.处理一年之内: 02-22 12:22
//        let cmps = calendar.components(.Year, fromDate: createDate, toDate: nowDate, options: [])
//        if cmps.year < 1 {
//            fmt.dateFormat = "MM-dd"
//            let timeStr = fmt.stringFromDate(createDate)
//            return timeStr
//        }
        
        // 5.7.超过一年: 2014-02-12 13:22
        fmt.dateFormat = "yyyy-MM-dd"
        let timeStr = fmt.string(from: createDate)
        return timeStr
    }
    
    // 返回周二，输入格式yyyy-MM-dd HH:mm:ss
    func timeTransformForWeek() -> String {
//        self = "2016-07-04 10:00:00"
        // 把 yyyy-MM-dd HH:mm:ss 转 yyyy-MM-dd
        if self.length < 10 {
            return ""
        }
        let dateStr = self.substringTo(10)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let oldDate = dateFormatter.date(from: dateStr) {
            let timeZone = TimeZone.autoupdatingCurrent
            let interval = timeZone.secondsFromGMT(for: oldDate)
            let date = oldDate.addingTimeInterval(Double(interval))
            let calendar = Calendar.current
            let comps = (calendar as NSCalendar).components(.weekday, from: date)
            let week:Int = comps.weekday!
            var result = ""
            
            switch week {
            case 1:
                result = "周日"
            case 2:
                result = "周一"
            case 3:
                result = "周二"
            case 4:
                result = "周三"
            case 5:
                result = "周四"
            case 6:
                result = "周五"
            case 7:
                result = "周六"
            default:
                result = ""
            }
            
            return result
        }
        
        return ""
    }
    
    func delSpaceWithString() -> String {
        let temp = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return temp
    }
    
    func isPureInt() -> Bool {
        if self.length == 11 {
            let tempStr = self.trimmingCharacters(in: CharacterSet.decimalDigits)
            if tempStr.length > 0 {
                return false
            }else {
                return true
            }
        }
        return false
    }
    
    func dateIntervalSinceNow() -> Int {
        let timeSta:TimeInterval = TimeInterval.init(self)!
        let date = Date(timeIntervalSince1970: timeSta/1000)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateStr = dateformatter.string(from: date)
        let date1 = dateformatter.date(from: dateStr)
        
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        let result = (gregorian as NSCalendar).components(NSCalendar.Unit.minute, from: date1!, to: Date(), options: NSCalendar.Options(rawValue: 0))
        
        return result.minute!
    }
    
    func removeFloatAllZero() -> String {
        let testNumber = NSString.init(string: self)
        var outNumber = String(format: "%.2f", testNumber.floatValue)
        var i = 1
        if self.contains(".") {
            while i < self.characters.count{
                if outNumber.hasSuffix("0"){
                    if outNumber.isEmpty {
                        break
                    }
                    let index = outNumber.index(outNumber.endIndex, offsetBy: -1)
                   outNumber = outNumber.substring(to: index)
                    i = i + 1
                }else{
                    break
                }
            }
            if outNumber.hasSuffix("."){
                let index = outNumber.index(outNumber.endIndex, offsetBy: -1)
                outNumber = outNumber.substring(to: index )
            }
            return outNumber
        }  else{
            return self
        }
    }
    
    func removeFloatAllZeroFloat4() -> String {
        let testNumber = NSString.init(string: self)
        var outNumber = String(format: "%.4f", testNumber.floatValue)
        var i = 1
        if self.contains(".") {
            while i < self.characters.count{
                if outNumber.hasSuffix("0"){
                    if outNumber.isEmpty {
                        break
                    }
                    let index = outNumber.index(outNumber.endIndex, offsetBy: -1)
                    outNumber = outNumber.substring(to: index)
                    i = i + 1
                }else{
                    break
                }
            }
            if outNumber.hasSuffix("."){
                let index = outNumber.index(outNumber.endIndex, offsetBy: -1)
                outNumber = outNumber.substring(to: index )
            }
            return outNumber
        }  else{
            return self
        }
    }
    
    //金额逗号分隔
    func changeAmount() -> String {
        let format = NumberFormatter()
        //设置numberStyle（有多种格式）
        format.numberStyle = .decimal
        format.maximumFractionDigits = 4
        //转换后的string
        let string = format.string(from: NSNumber(value: Double(self)!))
        
        return string!
        
    }
    
    // Range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    // 在某个地方插入字符串
    func insertStrInLocation(_ location: Int, _ str: String) -> String {
        
        let prefix = self.substringTo(location)
        let suffix = self.substringFrom(location)
        
        return prefix + str + suffix
    }
    
    // 返回字符串在字符串中的位置
    func LocationOfRangeString(_ text: String) ->Int {
        if self.contains(text) {
            return self.nsRange(from: self.range(of: text)!).location

        }else {
            return self.length
        }
    }
    // 你在说什么subStringToLocationStr(什么) -> 你在说
    func subStringToLocationStr(_ str: String) -> String{
        
        return self.substringTo(self.LocationOfRangeString(str))
    }
    
    // 获取小数点后面的位数
    func getTheDecimalCount() -> Int {
        
        return self.length - self.LocationOfRangeString(".")
    }
    
    // 超过多少位保留多少位,其他的不变
    func getDetaultRemainCountString(_ remainCount: Int) -> String {
        
        if self.getTheDecimalCount() > remainCount {
            if remainCount == 2{
                
                return String(format: "%.2f", Float(self)!)
            }else {
                return String(format: "%.4f", Float(self)!)

            }
        }else {
            return self
        }
    }
    
    // 是否包含emoji表情
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }

    func attributedStringWithKeywords(_ keywords:String, highLightColor:UIColor)->NSAttributedString{
        let aAttributedString = NSMutableAttributedString.init(string: self)
        aAttributedString.addAttribute( NSForegroundColorAttributeName, value: highLightColor, range: NSRange.init(location: LocationOfRangeString(keywords), length: keywords.length))
        return aAttributedString
    }

}
