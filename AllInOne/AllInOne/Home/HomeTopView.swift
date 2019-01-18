//
//  HomeTopView.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/17.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class HomeTopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        
        self.backgroundColor = UIColor(hex: "#33384C")
        
        let titleLable = UILabel()
        titleLable.font = UIFont.systemFont(ofSize: 28)
        titleLable.frame = CGRect(x: 0, y: (340/2 - 28)/2 + 20, width: self.frame.size.width, height: 28)
        titleLable.textColor = UIColor.white
        titleLable.text = "聚所有"
        titleLable.textAlignment = .right
        self.addSubview(titleLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
