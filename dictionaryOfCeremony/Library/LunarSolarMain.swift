//
//  main.swift
//  LunarSolarConverter
//
//  Created by isee15 on 15/1/17.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

import Foundation

func getLunarDate(solarDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "zh-Tw_POSIX")
    formatter.dateStyle = .medium
    let cal = Calendar(identifier: .chinese)
    formatter.calendar = cal
    return formatter.string(from: solarDate)
}

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

//var solar = Solar(solarYear: 2263, solarMonth: 2, solarDay: 7)
//var lunar = LunarSolarConverter.SolarToLunar(solar)
//print("lunar: \(lunar.lunarYear) \(lunar.lunarMonth) \(lunar.lunarDay) \(lunar.isleap)")
//solar = LunarSolarConverter.LunarToSolar(lunar);
//print("solar: \(solar.solarYear) \(solar.solarMonth) \(solar.solarDay)")

func check() -> Void {
    var begin = dateFrom(year: 1900, month: 1, day: 1);
    let end = dateFrom(year: 2300, month: 1, day: 1);

    let calendar = Calendar(identifier: .gregorian)
    let lunarCal = Calendar(identifier: .chinese)

    var yy = 0;
    while begin.compare(end) == ComparisonResult.orderedAscending {
        let swLunar = lunarCal.dateComponents([.day, .month, .year], from: begin)
        let components = calendar.dateComponents([.day, .month, .year], from: begin)
        
        var solar = Solar(solarYear: (components.year)!, solarMonth: (components.month)!, solarDay: (components.day)!)
        let lunar = LunarSolarConverter.SolarToLunar(solar: solar)
        if (components.year! > yy) {
            yy = (components.year)!;
            print("year: \(yy)");
        }
        let formatter = DateFormatter()
        //formatter.locale = NSLocale(localeIdentifier: "zh-Tw_POSIX")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCal
        let lunarString = formatter.string(from: begin)
        let lunarYear = lunarString[...4]
        // swLunar.year is like 甲子
        if (lunar.lunarYear != Int(lunarYear) || lunar.lunarMonth != swLunar.month || lunar.lunarDay != swLunar.day || lunar.isleap != swLunar.isLeapMonth) {
            print("swlunar: \(lunarYear) \(swLunar.month ?? 07) \(swLunar.day ?? 15) \(swLunar.isLeapMonth ?? false)")
            print("lunar: \(lunar.lunarYear) \(lunar.lunarMonth) \(lunar.lunarDay) \(lunar.isleap)")
            solar = LunarSolarConverter.LunarToSolar(lunar: lunar);
            print("solar: \(solar.solarYear) \(solar.solarMonth) \(solar.solarDay)")
        }
        begin = begin.addingTimeInterval(60 * 60 * 24);
    }

    print("done");
}

//print(getLunarDate(solarDate: dateFrom(year: 2097, month: 8, day: 7)))
//print(getLunarDate(solarDate: dateFrom(year: 2057, month: 9, day: 28)))
//print(getLunarDate(solarDate: dateFrom(year: 1900, month: 1, day: 30)))
//print(getLunarDate(solarDate: dateFrom(year: 1900, month: 1, day: 31)))
//print(getLunarDate(solarDate: dateFrom(year: 1901, month: 1, day: 20)))
//
//
//generate lunarMonth and solar11 data
//let gen = GenSourceData()
//gen.genData(beginY: 1900, endY: 2300);
//
//check()

