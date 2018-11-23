//
//  CalendarModel.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/23.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit
import SwiftyJSON

class CalendarModel: NSObject {
    
    var suit : String? //宜
    var weekday : String? //星期
    var avoid : String? //忌
    var zodiac : String? //生肖
    var lunar : String? //农历
    var lunarYear : String? //农历年
    var date: String?
    
        init(jsonData: JSON) {
            let resultDic = jsonData["result"].dictionary
            suit = resultDic?["suit"]?.stringValue
            weekday = resultDic?["weekday"]?.stringValue
            avoid = resultDic?["avoid"]?.stringValue
            zodiac = resultDic?["zodiac"]!.stringValue
            lunar = resultDic?["lunar"]?.stringValue
            lunarYear = resultDic?["lunarYear"]?.stringValue
            date = resultDic?["date"]?.stringValue
        }
}
/*
class CalendarModel: CommonModel {

    var suit : String? //宜
    var weekday : String? //星期
    var avoid : String? //忌
    var zodiac : String? //生肖
    var lunar : String? //农历
    var lunarYear : String? //农历年
    
//    init(jsonData: JSON) {
//        let resultDic = jsonData["result"].dictionary
//        suit = resultDic?["suit"]?.stringValue
//        weekday = resultDic?["weekday"]?.stringValue
//        avoid = resultDic?["avoid"]?.stringValue
//        zodiac = resultDic?["zodiac"]!.stringValue
//        lunar = resultDic?["lunar"]?.stringValue
//        lunarYear = resultDic?["lunarYear"]?.stringValue
//    }
}
 */
