# XLTimeManager
统一时间转换及时间计算

Usage

'''
//Date转String
let today = Date()
let todayString = today.dateString(.full)
print(today)        //2019-02-27 04:11:05 +0000
print(todayString) //2019-02-27 Wednesday 04:11

//String转Date, 也可创建Date
let aDaystr = "2019-02-27 03:55"
let aDay = aDaystr.dateFromFormatter(type: .e)
print(aDay!) //2019-02-27 03:55:00 +0000

//直接获取Date的年月日时分秒
let month = today.month()
let monthA = today.month_textAbbr()
let monthT = today.month_textFull()
print(month) //02
print(monthA)//Feb
print(monthT)//February

//日期增加计算
let newDay = today.adding(day: 5, month: 0, year: 0)
print(newDay!) //2019-03-04 04:11:05 +0000

//创建Date
let newdate = XLTimeManager.createADay(year: 2019, month: 3, day: 4)
print(newdate!) //2019-03-04 00:00:00 +0000

//日期差值计算 (diff>0:新日期大于老日期, diff<0:新日期小于老日期)
let diff = today.differDays(date: newdate!)
print(diff) //4

let newdate2 = XLTimeManager.createADay(year: 2019, month: 2, day: 27)
let diff2 = newdate!.differDays(date: newdate2!)
print(diff2) //-5
'''
