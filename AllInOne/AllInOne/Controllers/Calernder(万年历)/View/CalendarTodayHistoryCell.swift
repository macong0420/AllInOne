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
        let view = UIView(frame: CGRect(x: 20, y: 20, width: ScreenW-40, height: 100))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
        return view
    }()
    //历史上的今天
    lazy var titleImageView: UIImageView = {
        let img = UIImage(named: "dmtr_nav_title_228x24_")
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: 5, y: 5, width: img!.size.width, height: img!.size.height)
        return imgView
    }()
    
    //年份
    lazy var yaerLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 5, y: 30, width: 28, height: 50)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    //事件
    lazy var eventLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 45, y: 35, width: backView.frame.size.width-50, height: 70)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        return label
    }()
    
    //模型
    var historyModel: CalendarHistoryModel? {
        didSet{
            yaerLabel.text = historyModel?.date
            eventLabel.text = historyModel?.event
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor.groupTableViewBackground
        contentView.addSubview(backView)
        backView.addSubview(titleImageView)
        backView.addSubview(yaerLabel)
        backView.addSubview(eventLabel)
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
