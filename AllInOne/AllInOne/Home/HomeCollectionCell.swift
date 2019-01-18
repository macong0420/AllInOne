//
//  HomeCollectionCell.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/18.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import SnapKit

class HomeCollectionCell: UICollectionViewCell {
    
    var iconImgView : UIImageView?
    var nameLabel : UILabel?
    
    var iconImg: String? {
        didSet {
            iconImgView?.image = UIImage(named: iconImg ?? "")
        }
    }
    
    var title: String? {
        didSet{
            nameLabel?.text = title ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        iconImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        iconImgView?.center = self.contentView.center
        iconImgView?.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(iconImgView!)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 60+20, width: 100, height: 20))
        nameLabel?.font = UIFont.systemFont(ofSize: 18)
        nameLabel?.textColor = UIColor.black
        nameLabel?.textAlignment = .center
        self.contentView.addSubview(nameLabel!)
        
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(iconImgView?.snp.bottom ?? 80).offset(10)
            make.centerX.equalTo(iconImgView!.snp.centerX)
        })
        
    }
    
}
