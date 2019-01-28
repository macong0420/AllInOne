//
//  NetWorkTools.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/25.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import Alamofire

enum RequestMethodType {
    case GET
    case POST
}

class NetWorkTools {
    class func postRequest(urlString: String, parameters: [String : Any]?, successCallBack : @escaping (_ result : AnyObject) -> ()) {
        
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else { return }
            successCallBack(result as AnyObject)
        }
    }
    
    class func getRequest(urlString: String, parameters: [String : Any]?, successCallBack : @escaping (_ result : AnyObject) -> ()) {
        
        Alamofire.request(urlString, method: HTTPMethod.get, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else { return }
            successCallBack(result as AnyObject)
        }
    }
}

