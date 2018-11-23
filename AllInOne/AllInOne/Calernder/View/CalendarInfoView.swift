//
//  CalendarInfoView.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/23.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit
import SnapKit

class CalendarInfoView: UIView {

    lazy var suitImageView : UIImageView  = {
        let img = UIImage(named: "ico_yi_19x19_")!
        let imgV = UIImageView(frame: CGRect(x: kMagin, y: kMagin, width: img.size.width, height: img.size.height))
        imgV.image = img
        return imgV
    }()
    
    lazy var suitLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: kMagin, y: suitImageView.frame.origin.y+28+10, width: ScreenW-kMagin*2, height: 28))
        return label
    }()

    
    lazy var avoidIamgeView : UIImageView = {
        let img = UIImage(named: "ico_ji_19x19_")!
        let imgV = UIImageView(frame: CGRect(x: kMagin, y: suitLabel.frame.origin.y+10+img.size.height, width: img.size.width, height: img.size.height))
        imgV.image = img
        return imgV
    }()
    
    lazy var daindainImageView : UIImageView = {
        let img = UIImage(named: "diandiandiandian")
        let imgView = UIImageView(image: img)
        return imgView
    }()
//    var avoidLabel : UILabel?
    
    var model: CalendarModel? {
        didSet{
            suitLabel.text = model?.suit
        }
    }

     init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(suitImageView)
        addSubview(suitLabel)
        addSubview(avoidIamgeView)
        addSubview(daindainImageView)
        
        daindainImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(10)
            make.top.equalTo(suitImageView.snp.bottom).offset(10)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-10)
            make.height.equalTo(daindainImageView.frame.size.height)
        }
        
        self.backgroundColor = UIColor.white
        
    }
    
}
