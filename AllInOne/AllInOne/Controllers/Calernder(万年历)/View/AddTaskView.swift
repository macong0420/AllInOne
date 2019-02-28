//
//  AddTaskView.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/30.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import SnapKit

class AddTaskView: UIView {

    lazy var topView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: ScreenW, height: 100)
        view.backgroundColor = UIColor(hex: "4D6AD5")
        return view
    }()
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = "我的打卡"
        label.frame = CGRect(x: 0, y: 40, width: ScreenW, height: 24)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.white
        return label
    }()
    
    
    lazy var timeLable: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var titleInputView: UITextField = {
        
        let input = UITextField()
        input.placeholder = "标题"
        input.addTarget(self, action: #selector(titleInputChange(iputField:)), for: UIControl.Event.editingChanged)
        input.font = UIFont.systemFont(ofSize: 20)
        return input
        
    }()
    
    lazy var titleLineView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor(hex: "ececec")
        return view
    }()

    
    var chooseDate: Date?
    
    var title: String = ""
    
    init(chooseDate: Date) {
        self.chooseDate = chooseDate
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.white
        self.addSubview(topView)
        self.addSubview(titleLable)
        self.addSubview(timeLable)
        self.addSubview(titleInputView)
        self.addSubview(titleLineView)
        
        subViewsLayout()
        timeLable.text = setAddDate(date: self.chooseDate!)
        
    }
    
    
    func subViewsLayout() {
        timeLable.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(24)
        }
        
        titleInputView.snp.makeConstraints { (make) in
            make.top.equalTo(timeLable.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(20)
        }
        
        titleLineView.snp.makeConstraints { (make) in
            make.top.equalTo(titleInputView.snp.bottom).offset(5)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(0.5)
        }
    }
    
    @objc func titleInputChange(iputField: UITextField) {
        
        title = iputField.text ?? ""
    }

    func setAddDate(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormater.string(from: date)
        return dateString
    }
}
