# XLTimeManager Usage
统一时间转换及时间计算


## Date转String
```
let today = Date()
let todayString = today.dateString(.full)
print(today)        //2019-02-27 04:11:05 +0000
print(todayString) //2019-02-27 Wednesday 04:11
```

## String转Date, 也可创建Date
```
let aDaystr = "2019-02-27 03:55"
let aDay = aDaystr.dateFromFormatter(type: .e)
print(aDay!) //2019-02-27 03:55:00 +0000
```
## 直接获取Date的年月日时分秒
```
let month = today.month()
let monthA = today.month_textAbbr()
let monthT = today.month_textFull()
print(month) //02
print(monthA)//Feb
print(monthT)//February
```

## 日期增加计算
```
let newDay = today.adding(day: 5, month: 0, year: 0)
print(newDay!) //2019-03-04 04:11:05 +0000
```

## 创建Date
```
let newdate = XLTimeManager.createADay(year: 2019, month: 3, day: 4)
print(newdate!) //2019-03-04 00:00:00 +0000
```

## 日期差值计算
 ### (1) differDays和differDate只计算差值，适用于倒计时，不足24小时差值不算做1天
 ### (2) dayInterval、isSameDay、isBefore、isAfter 无视时分秒计算日期差值

```
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
let sameDay = XDate!.isSameDay(another: YDate!)
print(sameDay)  //false
let before = XDate!.isBefore(day: YDate!)
print(before)   //false
let after = XDate!.isAfter(day: YDate!)
print(after)    //true
```

## 时间戳转换date
```
let timeinverval:TimeInterval = 1551252796
let sdate = timeinverval.dateFromTimeStamp()
print(sdate!) ///2019-02-27 07:33:16 +0000
```



