//
//  DBManager.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/3/1.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import WCDBSwift

class DBManager: NSObject {
    
    static let shared = DBManager()
    
    private override init() {
        
    }
    
    // 创建数据库
    //创建表
    func saveDataBase(title: String) -> () {
        let dakaInfo = DakaInfo()
        dakaInfo.dakaName = title
        dakaInfo.dakaDate = Date()
        dakaInfo.dakaisNotify = true
        dakaInfo.identifier = 1
        dakaInfo.isAutoIncrement = true
        //建表
        do {
            try BaseDakaDB.create(table: BaseDakaTable, of: DakaInfo.self)
        } catch {
            print("table create failed error message: \(error)")
        }
        
        //插入数据库
        do {
            try BaseDakaDB.insert(objects: dakaInfo, intoTable: BaseDakaTable)
        } catch {
            print("table create failed error message: \(error)")
        }
    }
    
    
    //删除表-数据
    func deleteDakaInfo(info: DakaInfo) -> Bool {
        do {
            try BaseDakaDB.delete(fromTable: BaseDakaTable, where: DakaInfo.CodingKeys.dakaName.is(info.dakaName ?? ""), orderBy: nil, limit: 1, offset: 0)
            return true
        } catch {
            print("删除失败")
            return false
        }
    }

}
