//
//  ViewController.swift
//  XLTimeManagerDemo
//
//  Created by xiaolei on 2019/2/27.
//  Copyright © 2019 xiaolei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var today = Date()
        
        print(today)
        
        today = XLTimeManager.createADay(year: 2019, month: 02, day: 06)!
        
        let year = today.year()
        let yearD = today.year_digital()
        let yearL = today.year_last2()
        print(year)
        print(yearD)
        print(yearL)
        
        let month = today.month()
        let monthD = today.month_digital()
        let monthA = today.month_textAbbr()
        let monthF = today.month_textFull()
        print(month)
        print(monthD)
        print(monthA)
        print(monthF)
        
        let day = today.day()
        let dayD = today.day_digital()
        print(day)
        print(dayD)
        
        let hour = today.hour()
        let hourD = today.hour_digital()
        print(hour)
        print(hourD)
        
        let minute = today.minute()
        let minuteD = today.minute_digital()
        print(minute)
        print(minuteD)
        
        let second = today.second()
        let secondD = today.second_digital()
        print(second)
        print(secondD)
        
        let week = today.week_digital()
        let weekA = today.week_textAbbr()
        let weekF = today.week_textFull()
        print(week)
        print(weekA)
        print(weekF)
        
        
        
        
        /*日期差值计算
         (1) differDays和differDate只计算差值，适用于倒计时，不足24小时差值不算做1天
         (2) dayInterval、isSameDay、isBefore、isAfter 无视时分秒计算日期差值
         */
        
        let XDaystr = "2019-02-21 03:55"
        let XDate = XDaystr.dateFromFormatter(type: .e)
        let YDaystr = "2019-02-24 03:54"
        let YDate = YDaystr.dateFromFormatter(type: .e)
        
        let diff = XDate!.differDays(date: YDate!)
        print(diff)     // 2
        let diff2 = XDate!.differDate(date: YDate!)
        print(diff2)    // [0, 0, 2]
        
        let days = XDate!.dayInterval(another: YDate!)
        print(days)     // 3
        let sameDay = XDate!.isSameDay(YDate!)
        print(sameDay)  //false
        let before = XDate!.isBefore(YDate!)
        print(before)   //false
        let after = XDate!.isAfter(YDate!)
        print(after)    //true
        
        //时间戳转换date
        let timeinverval:TimeInterval = 1551252796
        let sdate = timeinverval.dateFromTimeStamp()
        print(sdate!)
        
    }


}

