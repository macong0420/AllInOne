//
//  CalendarHistoryModel.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/12/19.
//  Copyright © 2018 马聪聪. All rights reserved.
//


import UIKit
import SwiftyJSON

class CalendarHistoryModel: NSObject {

    var date : String? // 具体时间
    var day : String? //星期
    var event : String? // 事件
    var title : String? //生肖
    var id : String?
    var month : String?
    
//    init(dicDate: JSON) {
//
//        date = dicDate?["date"]?.stringValue
//        day = dicDate?["day"]?.stringValue
//        event = dicDate?["event"]?.stringValue
//        title = dicDate?["title"]!.stringValue
//        id = dicDate?["id"]!.stringValue
//        month = dicDate?["month"]!.stringValue
//
////
//    }
}

class CalendarHistoryContentModel: NSObject {
    
    var historyModelArr : [CalendarHistoryModel] = [CalendarHistoryModel].init()
    init(jsonData: JSON) {
        
//        let resultArr = jsonData["result"].arrayObject
//        let data = try? JSONSerialization.data(withJSONObject: jsonData["result"].arrayObject, options: JSONSerialization.WritingOptions.prettyPrinted)
//        let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
        let array = jsonData["result"]
        //从JSON Array中进行循环解析
        for (_,subJson):(String,JSON) in array {
            
            let historyModel = CalendarHistoryModel()
            historyModel.date = subJson["date"].stringValue
            historyModel.day = subJson["day"].stringValue
            historyModel.event = subJson["event"].stringValue
            historyModel.title = subJson["title"].stringValue
            historyModel.id = subJson["id"].stringValue
            historyModel.month = subJson["month"].stringValue
            
            historyModelArr.append(historyModel)
            
        }

    }
    
}
