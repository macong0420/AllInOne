//
//  DAKAController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/27.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import WCDBSwift

class DAKAController: BaseViewController {
    
    //新建打卡按钮
    private lazy var addBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "AddTask")!
        let imgW = img.size.width
        btn.frame = CGRect(x: (ScreenW-imgW)/2, y: ScreenH-imgW-10, width: imgW, height: imgW)
        btn.addTarget(self, action: #selector(addDakaAction), for: UIControl.Event.touchUpInside)
        btn.setBackgroundImage(img, for: UIControl.State.normal)
        return btn
    }()
    
    private lazy var taskTableview: UITableView = {
        let img = UIImage(named: "AddTask")!
        let imgW = img.size.width
        let ract = CGRect(x: 0, y: kTopNavViewH+10, width: ScreenW, height: ScreenH-kTopNavViewH-20-imgW)
        let tableView = UITableView(frame: ract, style: UITableView.Style.plain)
        return tableView
    }()
    
    lazy var tableView: UITableView = {
        let tabV = UITableView(frame: CGRect(x: 0, y: kTopNavViewH + 20, width: ScreenW, height: ScreenH-kTopNavViewH-80), style: .plain)
        tabV.backgroundColor = UIColor.white
        tabV.register(CalenderTaskCell.self, forCellReuseIdentifier: kCalenderTaskCellID)
        tabV.separatorColor = .clear
        tabV.delegate = self
        tabV.dataSource = self
        return tabV
    }()
    
    //日程数据
    var dakaInfoS: Array = [DakaInfo]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(addBtn)
        topNavView.setTitle(title: "每日打卡")
        //刷新数据库
        reloadDakaInfo()
    }
    
    @objc func addDakaAction() {
        let alert = UIAlertController(title: "打卡名称", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (calcel) in
            
        }
        
        let okAction = UIAlertAction(title: "确定", style: .default) { (ok) in
            guard let title = alert.textFields?.first?.text else {return}
            DBManager.shared.saveDataBase(title: title)
            
            //刷新数据
            self.reloadDakaInfo()
        }
        alert.addTextField { (input) in
            input.placeholder = "请输入打卡名称"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
}

 //MARK:- 数据库相关
extension DAKAController {
    //检测是否有新建的打卡记录
    func reloadDakaInfo() {
        print("\(BaseDBPath)")
        do {
            let dakaInfos: [DakaInfo] = try BaseDakaDB.getObjects(fromTable: BaseDakaTable)
            if dakaInfos.count > 0 {
                dakaInfoS = dakaInfos.reversed()
            }
        } catch {
            print("查找失败")
        }
    }
}

// MARK:- UITableViewDataSource
extension DAKAController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dakaInfoS.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CalenderTaskCell = tableView.dequeueReusableCell(withIdentifier: kCalenderTaskCellID)! as! CalenderTaskCell
        cell.selectionStyle = .none
        let dakaInfo = dakaInfoS[indexPath.row]
        cell.dakaInfo = dakaInfo
        cell.infoTitle = dakaInfo.dakaName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: CalenderTaskCell = tableView.dequeueReusableCell(withIdentifier: kCalenderTaskCellID)! as! CalenderTaskCell
        cell.selecteBtn.isSelected = true
        cell.dakaInfo = dakaInfoS[indexPath.row]
    }
    
    
    //左滑删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let dakaInfo = dakaInfoS[indexPath.row]
        if DBManager.shared.deleteDakaInfo(info: dakaInfo) {
            reloadDakaInfo()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
