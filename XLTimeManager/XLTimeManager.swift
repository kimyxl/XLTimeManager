//
//  XLTimeManager.swift
//
//  Created by xiaolei on 2019/5/17.
//  Copyright © 2019 xiaolei. All rights reserved.

import Foundation

/*所有日期或时(包括date和string)，均为0时区 GMT*/

class XLTimeManager {
    static let calendar:Calendar = {
        var calendar = Calendar.init(identifier: .gregorian)
        calendar.timeZone = TimeZone.init(identifier: "GMT")!
        return calendar
    }()
    fileprivate static let formatter:DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone.init(identifier: "GMT")!
        let locale = Locale.init(identifier: "en_US")
        formatter.locale = locale
        return formatter
    }()
    fileprivate class func dateComponents(_ date:Date) -> DateComponents {
        let dateComponents = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.timeZone], from: date)
        return dateComponents
    }
    class func createADay(year:Int, month:Int, day:Int) -> Date? {
        var components = DateComponents.init()
        components.timeZone = TimeZone.init(identifier: "GMT")
        components.day = day
        components.month = month
        components.year = year
        let date = calendar.date(from: components)
        return date
    }
}

//Date与string转换，不涉及时区问题
extension String {
    ///timezone:GMT
    func dateFromFormatter(type formatterType:String2DateFormatterEnum) -> Date? {
        XLTimeManager.formatter.dateFormat = formatterType.rawValue
        let date = XLTimeManager.formatter.date(from: self)
        return date
    }
    ///timezone:GMT
    func dateFromFormatterStr(formatterStr:String) -> Date? {
        XLTimeManager.formatter.dateFormat = formatterStr
        let date = XLTimeManager.formatter.date(from: self)
        return date
    }
}

extension Date {
    ///timezone:GMT
    func dateString(_ style:Date2StringFormatterEnum) -> String {
        //特殊判断
        if self.specialShowFormatterList.contains(style) {
            return self.specialHandler(style)
        }
        //常规
        XLTimeManager.formatter.dateFormat = style.rawValue
        let convertedDateString = XLTimeManager.formatter.string(from: self)
        return convertedDateString
    }
    
    func adding(day:Int, month:Int=0, year:Int=0) -> Date? {
        var components = DateComponents.init()
        components.timeZone = TimeZone.init(identifier: "GMT")
        components.day = day
        components.month = month
        components.year = year
        let calculatedDate = XLTimeManager.calendar.date(byAdding: components, to: self)
        return calculatedDate
    }
    
    //无视时分秒计算日期差值
    func dayInterval(another:Date) -> Int {
        let date1 = XLTimeManager.createADay(year: self.year_digital(), month:  self.month_digital(), day: self.day_digital())
        let date2 = XLTimeManager.createADay(year: another.year_digital(), month:  another.month_digital(), day: another.day_digital())
        if let dateR1 = date1, let dateR2 = date2 {
            return dateR1.differDays(date:dateR2)
        }
        fatalError("create Date failure")
    }
    
    func isSameDay(another:Date) -> Bool {
        let days = self.dayInterval(another: another)
        if days == 0 { return true }
        return false
    }
    
    func isBefore(day beforeDate:Date) -> Bool {
        let days = self.dayInterval(another: beforeDate)
        if days > 0 { return true }
        return false
    }
    
    func isAfter(day afterDay:Date) -> Bool {
        let days = self.dayInterval(another: afterDay)
        if days < 0 { return true }
        return false
    }
    
    /// 两日期相差天数, 返回值为正负零, 可判断日期前后(不满24小时不算一天)
    func differDays(date:Date) -> Int {
        let diffDateComponents = XLTimeManager.calendar.dateComponents([Calendar.Component.day], from: self, to: date)
        return diffDateComponents.day ?? 0
    }
    /// 两日期相隔年月日 -> [年，月，日] (正负值) (不满24小时不算一天)
    func differDate(date:Date) -> [Int] {
        let diffDateComponents = XLTimeManager.calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: self, to: date)
        let year = diffDateComponents.year ?? 0
        let month = diffDateComponents.month ?? 0
        let day = diffDateComponents.day ?? 0
        return [year,month,day]
    }
    
    func year() -> String {
        return "\(self.year_digital())"
    }
    func year_digital() -> Int {
        let dateComponets = XLTimeManager.dateComponents(self)
        return dateComponets.year ?? 0
    }
    func year_last2() -> String {
        let str = self.year()
        let startIndex = str.index(str.endIndex, offsetBy: -2)
        return String(str[startIndex...])
    }
    
    func day() -> String {
        let num = self.day_digital()
        return self.dealSingleString(num)
    }
    func day_digital() -> Int {
        let dateComponets = XLTimeManager.dateComponents(self)
        return dateComponets.day ?? 0
    }

    func hour() -> String {
        let num = self.hour_digital()
        return self.dealSingleString(num)
    }
    func hour_digital() -> Int {
        let dateComponets = XLTimeManager.dateComponents(self)
        return dateComponets.hour ?? 0
    }
    
    func minute() -> String {
        let num = self.minute_digital()
        return self.dealSingleString(num)
    }
    func minute_digital() -> Int {
        let dateComponets = XLTimeManager.dateComponents(self)
        return dateComponets.minute ?? 0
    }
    
    func second() -> String {
        let num = self.second_digital()
        return self.dealSingleString(num)
    }
    func second_digital() -> Int {
        let dateComponets = XLTimeManager.dateComponents(self)
        return dateComponets.second ?? 0
    }
    
    func month() -> String {
        let num = self.month_digital()
        return self.dealSingleString(num)
    }
    func month_digital() -> Int {
        let dateComponets = XLTimeManager.dateComponents(self)
        return dateComponets.month ?? 0
    }
    func month_textFull() -> String {
        XLTimeManager.formatter.dateFormat = "MMMM"
        return  XLTimeManager.formatter.string(from: self)
    }
    func month_textAbbr() -> String {
        XLTimeManager.formatter.dateFormat = "MMM"
        return  XLTimeManager.formatter.string(from: self)
    }
    
    func week() -> String {
        let num = self.week_digital()
        return self.dealSingleString(num)
    }
    func week_digital() -> Int {
        let dateComponets = XLTimeManager.dateComponents(self)
        return dateComponets.weekday ?? 0
    }
    func week_textFull() -> String {
        XLTimeManager.formatter.dateFormat = "EEEE"
        return  XLTimeManager.formatter.string(from: self)
    }
    func week_textAbbr() -> String {
        XLTimeManager.formatter.dateFormat = "EEE"
        return  XLTimeManager.formatter.string(from: self)
    }
    private func dealSingleString(_ num:Int) -> String {
        if num < 10 {
            return "0\(num)"
        } else {
            return "\(num)"
        }
    }
}

extension TimeInterval {
    func dateFromTimeStamp() -> Date? {
        var num = self
        if self > 999999999999 {
            num /= 1000.0
        }
        let date = Date.init(timeIntervalSince1970: num)
        return date
    }
}




