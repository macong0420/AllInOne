//
//  CalendarInfoCell.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/23.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit
import SnapKit
import Hue

class CalendarInfoCell: UITableViewCell {

    lazy var backgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var suitImageView : UIImageView  = {
        let img = UIImage(named: "ico_yi_19x19_")!
        let imgV = UIImageView(frame: CGRect(x: kMagin, y: kMagin, width: img.size.width, height: img.size.height))
        imgV.image = img
        return imgV
    }()
    
    lazy var suitLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: kMagin, y: suitImageView.frame.origin.y+28+10, width: ScreenW-kMagin*2, height: 50))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    /// 点点...........
    lazy var daindainImageView1 : UIImageView = {
        let img = UIImage(named: "diandiandiandian")
        let imgView = UIImageView(image: img)
        return imgView
    }()
    
    /// 忌
    lazy var avoidLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var lunarLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "H-GungSeo", size: 50)
        label.textColor = UIColor(hex: "#544844")
        label.textAlignment = .center
        return label
    }()
    
    var model: CalendarModel? {
        didSet{
            suitLabel.text = model?.suit
            avoidLabel.text = model?.avoid
            lunarLabel.text = model?.lunar
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(suitImageView)
        contentView.addSubview(suitLabel)
        contentView.addSubview(avoidIamgeView)
        contentView.addSubview(daindainImageView)
        contentView.addSubview(daindainImageView1)
        contentView.addSubview(avoidLabel)
        contentView.addSubview(lunarLabel)
        
        var i = 0
        for family: String in UIFont.familyNames {
            print("\(i)---项目字体---\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("--- font \(names)")
            }
            i += 1
        }
        
        daindainImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(10)
            make.top.equalTo(suitImageView.snp.bottom).offset(10)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-10)
            make.height.equalTo(daindainImageView.frame.size.height)
        }
        
        avoidIamgeView.snp.makeConstraints { (make) in
            make.left.equalTo(kMagin)
            make.top.equalTo(suitLabel.snp.bottom).offset(10)
            make.height.equalTo(avoidIamgeView.frame.size.height)
            make.width.equalTo(avoidIamgeView.frame.size.width)
        }
        
        daindainImageView1.snp.makeConstraints { (make) in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(10)
            make.top.equalTo(avoidIamgeView.snp.bottom).offset(10)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-10)
            make.height.equalTo(daindainImageView.frame.size.height)
        }
        
        avoidLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kMagin)
            make.top.equalTo(daindainImageView1.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.right.equalTo(kMagin)
        }
        
        lunarLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kMagin)
            make.right.equalTo(-kMagin)
            make.top.equalTo(avoidLabel.snp.bottom).offset(20)
            make.height.equalTo(70)
        }
        
        self.backgroundColor = UIColor.white
    }
    
}
