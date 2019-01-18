//
//  ExtenSion.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/17.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
