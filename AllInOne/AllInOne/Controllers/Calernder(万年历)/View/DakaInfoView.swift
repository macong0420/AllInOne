//
//  DakaInfoView.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/28.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class DakaInfoView: UIView {
    
    lazy var titleLabel: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: kMagin, y: 5, width: 200, height: 40)
        lable.font = UIFont.systemFont(ofSize: 25)
        return lable
    }()
    
    var infoTitle: String? {
        didSet {
            titleLabel.text = infoTitle
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
