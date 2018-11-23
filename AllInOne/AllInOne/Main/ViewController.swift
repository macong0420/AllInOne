//
//  ViewController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/21.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        let canlendarBtn = UIButton(type: .custom)
        canlendarBtn.setImage(UIImage(named: "Calernder"), for: .normal)
        canlendarBtn.addTarget(self, action: #selector(canlendarBtnAction), for: .touchUpInside)
        view.addSubview(canlendarBtn)
        
        canlendarBtn.snp.makeConstraints { (make) in
            make.top.equalTo(NavgationH + 20)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
       
        let canlendarLaber = UILabel()
        canlendarLaber.text = "万年历"
        canlendarLaber.textColor = UIColor.gray
        canlendarLaber.font = UIFont.systemFont(ofSize: 14)
        canlendarLaber.textAlignment = .center
        view.addSubview(canlendarLaber)
        
        canlendarLaber.snp.makeConstraints { (make) in
            make.top.equalTo(canlendarBtn.snp.bottom).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.centerX.equalTo(canlendarBtn)
        }
    }
    
    //MARK:- 按钮点击
    @objc private func canlendarBtnAction() {
        
        let calendarVC = CalendarController()
//        self.navigationController?.pushViewController(calendarVC, animated: true)
        navigationController?.pushViewController(calendarVC, animated: true)
    }
}

