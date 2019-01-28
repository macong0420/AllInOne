//
//  ExpressModel.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/25.
//  Copyright © 2019 马聪聪. All rights reserved.
//
//
//import UIKit
//
//class ExpressModel: NSObject {
//
//    var time = ""
//    var ftime = ""
//    var context = "" //快递物流信息
//    var location = ""
//
//    init(dict: [String : NSObject]) {
//        super.init()
//        setValuesForKeys(dict)
//    }
//
//    override func setValue(_ value: Any?, forKey key: String) {
//
//    }
//}

struct ExpressModel: Codable {
    
    var time: String?
    var ftime: String?
    var context: String? //快递物流信息
    var location: String?

}
