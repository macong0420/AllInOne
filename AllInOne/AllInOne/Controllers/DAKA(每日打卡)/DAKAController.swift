//
//  DAKAController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/27.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class DAKAController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addBtn)
    }
    
    
    
    @objc func addDakaAction() {
        let alert = UIAlertController(title: "打卡名称", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (calcel) in
            
        }
        let okAction = UIAlertAction(title: "确定", style: .default) { (ok) in
            
        }
        alert.addTextField { (input) in
            input.placeholder = "请输入打卡名称"
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    


}
