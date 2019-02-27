//
//  BaseShadowView.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/27.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class BaseShadowView: UIView {

    //阴影view
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.shadowColor = UIColor.init(hex: "#ececec").cgColor
        view.layer.shadowOpacity = 0.9
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backView.frame = CGRect(x: 10, y: 10, width: self.bounds.size.width-20, height: self.bounds.size.height-20)
        contentView.frame = CGRect(x: 2.5, y: 2.5, width: self.bounds.size.width-25, height: self.bounds.size.height-25)
        backView.addSubview(contentView)
        self.addSubview(backView)
        
    }
    
    func insertView(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.width)
        contentView.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
