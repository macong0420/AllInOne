//
//  RACRandomView.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/22.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

let inputW = (ScreenW - 2*kMagin - 100) / 2

class RACRandomView: UIView {

    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "请输入随机数范围"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 20)
        label.frame = CGRect(x: kMagin, y: 0, width: ScreenW-kMagin*2, height: 20)
        return label
    }()
    
    private lazy var firstInput: UITextField = {
        let input = UITextField()
        input.frame = CGRect(x: kMagin, y: 40, width: inputW, height: 20)
        input.text = "1"
        return input
    }()
    
    private lazy var secondInput: UITextField = {
        let input = UITextField()
        input.frame = CGRect(x: kMagin+inputW+100, y: 40, width: inputW, height: 20)
        input.text = "100"
        return input
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension RACRandomView {
    
    private func setupUI() {
        self.addSubview(tipsLabel)
        self.addSubview(firstInput)
        self.addSubview(secondInput)
        
    }
}
