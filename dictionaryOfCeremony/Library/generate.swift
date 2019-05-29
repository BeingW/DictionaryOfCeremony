//
//  main.swift
//  LunarSolarConverter
//
//  Created by isee15 on 15/1/17.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

import Foundation

class GenSourceData {
    let lunarCal = Calendar(identifier: .chinese)
    let unitFlags: NSCalendar.Unit = [.day, .month, .year]

    func dateFrom(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone(identifier: "GMT+0800")

        let swSolar = calendar.date(from: components)
        return swSolar!
    }

    func solarToLunar(curD: Date) -> DateComponents {
        let swLunar = lunarCal.dateComponents([.day, .month, .year], from: curD)

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh-Tw_POSIX")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCal
        let lunarString = formatter.string(from: curD)
        let lunarYear = lunarString[...4]

        var ret = DateComponents()
        ret.year = Int(lunarYear)!
        ret.month = swLunar.month
        ret.day = swLunar.day
        ret.isLeapMonth = swLunar.isLeapMonth
        return ret;
    }

    func lunar11ToSolar(year: Int) -> Date {
        var curD = dateFrom(year: year, month: 1, day: 15)
        while true {
            let lunarComponent = solarToLunar(curD: curD)
            if (lunarComponent.month == 1 && lunarComponent.day == 1) {
                return curD;
            }
            curD = curD.addingTimeInterval(60 * 60 * 24)
        }
    }

    func lunarMonth1FromSolar(solar11: Date) -> Int {
        var curD = solar11;
        //var days: [Int] = []
        var leap = 0;
        var ret = 0;
        let component11 = solarToLunar(curD: curD);
        for index in 1 ... 13 {
            //阴历月份只有30天和29天2种
            curD = curD.addingTimeInterval(29 * 60 * 60 * 24)
            var component = solarToLunar(curD: curD);
            if (component.day == 1 || component.day == 0) {
                //days.append(0);
                if (component11.year == component.year && component.isLeapMonth!) {
                    leap = index;
                } else if (component.month == 1 && component.day == 1 && component11.year == component.year! - 1) {
                    break;
                }

            } else {
                curD = curD.addingTimeInterval(60 * 60 * 24)
                component = solarToLunar(curD: curD);
                //正常这个地方一定能进去
                if ((component.day == 1 || component.day == 0) && component11.year == component.year) {
                    //days.append(1);
                    ret |= (1 << (13 - index));
                    if (component.isLeapMonth!) {
                        leap = index;
                    }
                } else if (component.month == 1 && component.day == 1 && component11.year == component.year! - 1) {
                    ret |= (1 << (13 - index));
                    break;
                } else {
                    print("error-------\(curD)");
                }
            }

        }
        return (leap << 13) | ret;
    }

    func genData(beginY: Int, endY: Int) -> Void {
        let calendar = Calendar(identifier: .gregorian)
        var s1 = "";
        var s2 = "";
        
        var y = beginY - 2
        
        while y < endY + 2 {
            y = y + 1
            let solarDate = lunar11ToSolar(year: y)
            let solarD = calendar.dateComponents([.day, .month, .year], from: solarDate)
            let solar11 = (y << 9) | (solarD.month! << 5) | (solarD.day!);
            s1 += "0x" + String(solar11, radix: 16) + ", ";
            let lunarMonth = lunarMonth1FromSolar(solar11: solarDate);
            s2 += "0x" + String(lunarMonth, radix: 16) + ", ";
            print("generate year: \(y) \(String(solar11, radix: 16)) \(String(lunarMonth, radix: 16))")
        }
    
        s1 += "";
        s2 += "";

        print("------------------------------")
        print("lunar_month_days=[\(beginY - 3),\(s2)]");
        print("------------------------------")
        print("solar_1_1=[\(beginY - 3),\(s1)]");
        print("done");

    }

}


