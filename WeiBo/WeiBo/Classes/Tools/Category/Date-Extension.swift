//
//  Date-Extension.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/26.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import Foundation

extension Date{
    
    /// 通过服务器返回的时间字符串，转换成正确的时间格式
    static func creatDateString(creatAtString : String) -> String {
        
        // 1.设置日期格式对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        // 2.将字符创时间转成Date对象
        guard let creatDate = fmt.date(from: creatAtString) else{
            return ""
        }
        
        // 3.创建当前时间
        let nowDate = Date()

        // 4.计算当前时间和创建时间的时间差
        let interval = Int(nowDate.timeIntervalSince(creatDate))
        
        
        // 5.时间间隔处理
        // 5.1 显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2 1小时内展示xx分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        // 5.3 1天内展示xx小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / 60)小时前"
        }
        
        // 5.4 创建日历对象
        let calender = Calendar.current
        
        
        // 5.5 处理昨天数据 昨天 12：33
        if calender.isDateInYesterday(creatDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: creatDate)
            return timeStr
        }
        
        
        // 5.6 处理一年内数据 02-22 12：33
        let cmps = calender.component(.year, from: creatDate)

        if cmps < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: creatDate)
            return timeStr
        }
        
        // 5.7 处理超过一年数据 2015-02-03  12:22
        if cmps >= 1 {
            fmt.dateFormat = "yyyy-MM-dd HH:mm"
            let timeStr = fmt.string(from: creatDate)
            return timeStr
        }

        
        return "1970-01-01 00：00"
    }
}
