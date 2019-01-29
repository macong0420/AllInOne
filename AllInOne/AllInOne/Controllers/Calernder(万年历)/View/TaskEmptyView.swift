//
//  TaskEmptyView.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/29.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class TaskEmptyView: UIView {
    
    lazy var emptyImgView: UIImageView = {
        let imgView = UIImageView()
        let img = UIImage(named: "EmptyTask")
        imgView.frame = CGRect(x: (ScreenW-ScreenW/3)/2, y: 0, width: ScreenW/3, height: ScreenW/3)
        imgView.image = img
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
       
        let label = UILabel()
        label.text = "暂无日程,快去添加吧"
        label.frame = CGRect(x: 20, y: ScreenW/3+20, width: ScreenW-40, height: 20)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        self.addSubview(emptyImgView)
        self.addSubview(titleLabel)
    }
}
