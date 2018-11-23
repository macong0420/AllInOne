//
//  CommonModel.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/23.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommonModel: NSObject {
    var msg: String?
    var retCode : String?
    var result :[String : Any]?
    
    init(jsonData: JSON) {
        msg = jsonData["msg"].stringValue
        retCode = jsonData["retCode"].stringValue
        result = jsonData["result"].dictionary
    }
    
}
