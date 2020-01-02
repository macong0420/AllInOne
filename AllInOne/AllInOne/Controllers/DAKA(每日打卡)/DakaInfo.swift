//
//  DakaInfo.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/28.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class DakaInfo: TableCodable {

    var identifier: Int? = nil     //标识ID
    var description: String? = nil //描述
    var dakaName: String? = nil    //打卡名称
    var dakaDate: Date? = nil      //打卡时间
    var dakaisNotify: Bool? = true //是否通知
    var dakaSuccess: Bool? = false //是否打卡
    
    init() {
        identifier = 0
    }
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = DakaInfo
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case description
        case dakaName
        case dakaDate
        case dakaisNotify
        case dakaSuccess
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true),
            ]
        }
    }
    
    var isAutoIncrement: Bool = true
    var lastInsertedRowID: Int64 = 0
    
}
