//
//  ExpressCell.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/18.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class ExpressCell: UITableViewCell {
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    
    func setupUI() {
        
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
