//
//  CalendarTodayHistoryCell.swift
//  AllInOne
//
//  Created by 马聪聪 on 2018/11/23.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

class CalendarTodayHistoryCell: UITableViewCell {

    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 5, y: 5, width: ScreenW-10, height: 100))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = true
        return view
    }()
    //历史上的今天
    lazy var titleImageView: UIImageView = {
        let img = UIImage(named: "dmtr_nav_title_228x24_")
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: 0, y: 0, width: img!.size.width, height: img!.size.height)
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(backView)
        backView.addSubview(titleImageView)
    }
    
    
    
    //MARK:---------- 无用废代码-----------------
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
