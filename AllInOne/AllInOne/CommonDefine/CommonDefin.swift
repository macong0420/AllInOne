//
//  File.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/21.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

let APPKEY = "28da3fa01d240"
let EXPressAPPKEy = "e7285c2b-f97a-4b8c-9635-847ad3987854"
let ExpressUserId = "1434396"

///日历 宜忌
let kCalendarAPI = "http://apicloud.mob.com/appstore/calendar/day"
/// 历史上的今天
let kHistoryTodayAPI = "http://apicloud.mob.com/appstore/history/query"

let ScreenW : CGFloat = UIScreen.main.bounds.size.width
let ScreenH : CGFloat = UIScreen.main.bounds.size.height

let kMagin : CGFloat = 20

var StatusBarH : CGFloat = isIPhoneXType() ? 44 : 20
var NavgationH : CGFloat = isIPhoneXType() ? 88 : 64


func isIPhoneXType() -> Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets != UIEdgeInsets.zero
}



