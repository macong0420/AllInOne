//
//  CommonTopNavView.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/19.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class CommonTopNavView: UIView {

    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let labelY = kTopNavViewH - 10 - 40
        label.frame = CGRect(x: kMagin, y: labelY, width: ScreenW-kMagin*2, height: 40)
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    
     init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.titleLabel.text = title
        setupUI()
        
    }
    
    private func setupUI() {
        self.addSubview(titleLabel)
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.init(hex: "#ececec").cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



