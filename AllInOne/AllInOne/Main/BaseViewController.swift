//
//  BaseViewController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/27.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
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
    
    lazy var topNavView: CommonTopNavView = {
        let rect = CGRect(x: 0, y: 0, width: ScreenW, height: kTopNavViewH)
        let topView = CommonTopNavView(frame: rect, title: "")
        return topView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(topNavView)
        view.addSubview(closeBtn)

    }
    
    //关闭
    @objc func closeAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
    


}
