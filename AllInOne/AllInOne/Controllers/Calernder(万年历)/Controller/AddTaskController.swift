//
//  AddTaskController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/30.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit


class AddTaskController: UIViewController {
    
    //关闭按钮
    lazy var closeBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        let img = UIImage(named: "Close")!
        btn.setBackgroundImage(img, for: .normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: 20, y: 40, width: img.size.width, height: img.size.height)
        btn.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    //关闭按钮
    lazy var saveBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        let img = UIImage(named: "ok")!
        btn.setBackgroundImage(img, for: .normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: ScreenW-img.size.width-20, y: 40, width: img.size.width, height: img.size.height)
        btn.addTarget(self, action: #selector(saveAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var addTaskView: AddTaskView = {
        
        let view = AddTaskView(chooseDate: self.chooseDate!)
        view.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH)
        return view
    }()
    
    
    var chooseDate: Date?
    
    init(chooseDate: Date) {
        self.chooseDate = chooseDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addTaskView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
    }

    //关闭
    @objc func closeAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    //保存
    @objc func saveAction() {
        
    }

}
