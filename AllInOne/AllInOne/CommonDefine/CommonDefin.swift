//
//  File.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/21.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

let ScreenW : CGFloat = UIScreen.main.bounds.size.width
let ScreenH : CGFloat = UIScreen.main.bounds.size.height

var StatusBarH : CGFloat = isIPhoneXType() ? 44 : 20
var NavgationH : CGFloat = isIPhoneXType() ? 88 : 64


func isIPhoneXType() -> Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets != UIEdgeInsets.zero
}



