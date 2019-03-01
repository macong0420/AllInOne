//
//  CalenderTaskCell.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/29.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class CalenderTaskCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: kMagin, y: 5, width: 200, height: 70)
        lable.font = UIFont.systemFont(ofSize: 25)
        return lable
    }()
    
    lazy var selecteBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "选择框")!
        let imgEd = UIImage(named: "已选择")
        let imgW = img.size.width
        btn.frame = CGRect(x: ScreenW-kMagin*2-imgW-20, y: (80-imgW)/2, width: imgW, height: imgW)
        btn.setBackgroundImage(img, for: UIControl.State.normal)
        btn.setBackgroundImage(imgEd, for: UIControl.State.selected)
        btn.addTarget(self, action: #selector(btnSeclecte(btn:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    var infoTitle: String? {
        didSet {
            titleLabel.text = infoTitle
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    func setupUI() {
        let dakaView = BaseShadowView(frame: CGRect(x: kMagin, y: 0, width: ScreenW-kMagin*2, height: 80))
        let dakaInfoView = DakaInfoView(frame: CGRect(x: 0, y: 0, width: ScreenW-kMagin*2, height: 80))
        dakaInfoView.addSubview(titleLabel)
        dakaView.addSubview(dakaInfoView)
        self.contentView.addSubview(dakaView)
        self.contentView.addSubview(selecteBtn)
    }
    
    
    @objc func btnSeclecte(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
