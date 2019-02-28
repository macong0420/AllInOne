//
//  DakaInfo.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/28.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import WCDBSwift

class DakaInfo: TableCodable {

    var identifier: Int? = nil
    var description: String? = nil
    var dakaName: String? = nil
    var dakaDate: Date? = nil
    var dakaisNotify: Bool? = true
    
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
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true),
            ]
        }
    }
    
    var isAutoIncrement: Bool = true
    var lastInsertedRowID: Int64 = 0
    
}
