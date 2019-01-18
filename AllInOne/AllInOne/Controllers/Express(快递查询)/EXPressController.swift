//
//  EXPressController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/18.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class EXPressController: UIViewController {
    
    
    var expressCodeInputField: UITextField?
    var expressSelcteBtn: UIButton?
    var checkBtn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
   

}


extension EXPressController: UITextFieldDelegate,EXPressComponyDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func dismis(string:String) {
        expressSelcteBtn?.setTitle(string, for: UIControl.State.normal)
    }
}


extension EXPressController {
    private func setupUI() {
        
        self.view.backgroundColor = UIColor.white
        
        
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "Close"), for: UIControl.State.normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: 20, y: 80, width: 40, height: 40)
        btn.addTarget(self, action: #selector(btnAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
        
        expressCodeInputField = UITextField(frame: CGRect(x: 40, y: 130, width: ScreenW-80, height: 40))
        expressCodeInputField?.delegate = self
        expressCodeInputField?.layer.cornerRadius = 5
        expressCodeInputField?.layer.masksToBounds = true
        expressCodeInputField?.layer.borderColor = UIColor.gray.cgColor
        expressCodeInputField?.layer.borderWidth = 1
        expressCodeInputField?.keyboardType = .numberPad
        expressCodeInputField?.placeholder = "请输入您的快递单号"
        expressCodeInputField?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        expressCodeInputField?.leftViewMode = .always
        self.view.addSubview(expressCodeInputField!)
        
        expressSelcteBtn = UIButton(type: UIButton.ButtonType.custom)
        expressSelcteBtn?.frame = CGRect(x: 40, y: 200, width: ScreenW-80, height: 40)
        expressSelcteBtn?.setTitle("请选择快递公司", for: UIControl.State.normal)
        expressSelcteBtn?.setTitleColor(UIColor.black, for: UIControl.State.normal)
        expressSelcteBtn?.layer.masksToBounds = true
        expressSelcteBtn?.layer.cornerRadius = 5
        expressSelcteBtn?.layer.borderColor = UIColor.gray.cgColor
        expressSelcteBtn?.layer.borderWidth = 1
        expressSelcteBtn?.addTarget(self, action: #selector(expressSelcteBtnAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(expressSelcteBtn!)
        
        checkBtn = UIButton(type: UIButton.ButtonType.custom)
        checkBtn?.frame = CGRect(x: 80, y: 260, width: ScreenW-160, height: 40)
        checkBtn?.setTitle("查询", for: UIControl.State.normal)
        checkBtn?.layer.cornerRadius = 5
        checkBtn?.layer.masksToBounds = true
        checkBtn?.backgroundColor = UIColor.orange
        checkBtn?.addTarget(self, action: #selector(checkBtnAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(checkBtn!)
        
        
    }
    
    @objc func btnAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    @objc func expressSelcteBtnAction() {
        
        let conpenyVC = EXPressCompony()
        conpenyVC.delegate = self as EXPressComponyDelegate
        
        self.present(conpenyVC, animated: true) {
            
        }
    }
    
    ///真正去查询
    @objc func checkBtnAction() {
        
    }
}



///----------快递公司选择控制器-------

///代理 反向传值
protocol EXPressComponyDelegate {
    func dismis(string:String)
}


class EXPressCompony: UIViewController {
    
    var expressArray: NSArray? //快递名称
    var expressCodeArray: NSArray? //快递编码
    var selectStr: String?
    var delegate: EXPressComponyDelegate?
    var expressDic: NSDictionary?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "Close"), for: UIControl.State.normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: 20, y: 80, width: 40, height: 40)
        btn.addTarget(self, action: #selector(btnAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
        
        expressArray = ["顺丰快递","天天快递","圆通速递","申通快递","百世快递","中通速递","韵达快递","EMS","邮政平邮/小包","德邦",
                        "AXD","安信达快递","AYCA","澳邮专线","BQXHM","北青小红帽","BFDF","百福东方","BTWL","百世快运","HTKY","CNPEX","CNPEX中邮快递",
                        "CCES","CCES快递","COE","COE东方快递","CJKD","城际快递","CITY100","城市100","CSCY","长沙创一","DBL","DSWL","D速物流","DTWL",
                        "大田物流","EMS","FEDEX","FEDEX联邦(国内件）","FEDEX_GJ","FEDEX联邦(国际件）", "PANEX","泛捷快递","FKD","飞康达","GDEMS","广东邮政","GSD",
                        "共速达","GTO","国通快递","GTSD","高铁速递", "HOTSCM","鸿桥供应链","HPTEX","海派通物流公司","HFWL","汇丰物流","ZHQKD","汇强快递","HLWL","恒路物流","hq568",
                        "华强物流","HXLWL","华夏龙物流","HYLSD","好来运快递","JGSD","京广速递","JIUYE","九曳供应链","JJKY","佳吉快运","JLDT","嘉里物流","JTKD","捷特快递","JXD",
                        "急先达","JYKD","晋越快递","JYM","加运美","JYWL","佳怡物流","FAST","快捷速递","QUICK","快客快递","KYWL","跨越物流","LB","龙邦快递","LHT","联昊通速递","MHKD",
                        "民航快递","MLWL","明亮物流","NEDA","能达速递","PADTF","平安达腾飞快递","PCA","PCA Express","QCKD","全晨快递","QFKD","全峰快递","UAPEX","全一快递","QRT",
                        "全日通快递","RFD","如风达","RFEX","瑞丰速递","SUBIDA","速必达物流","SAD","赛澳递","SAWL","圣安物流","SBWL","盛邦物流","SDWL", "上大物流","SF",
                        "SFWL","盛丰物流","SHWL","盛辉物流","ST","速通物流","STO","STWL", "速腾快递","SURE","速尔快递","HOAU","天地华宇","HHTT",
                        "TSSTO","唐山申通","UEQ","UEQ Express","WJWL","万家物流","WXWL","万象物流","XBWL","新邦物流","XFEX","信丰快递","XYT","希优特","XJ",
                        "新杰物流", "UC","优速快递","AMAZON","亚马逊物流","YADEX","源安达快递","YCWL","远成物流","YD","YDH","义达国际物流","YFEX","越丰物流","YFHEX",
                        "原飞航物流","YFSD","亚风快递","YTKD","运通快递","YTO", "YXKD","亿翔快递","YZPY","ZENY","增益快递","ZJS","宅急送","ZTE","众通快递",
                        "ZTKY","中铁快运","ZTO","ZTWL","中铁物流","ZYWL","中邮物流"]
        
        expressDic = NSDictionary(objects: ["AXD","AYCA","BQXHM","BFDF","BTWL","HTKY","CNPEX","CCES", "COE","CJKD","CITY100","CSCY","DBL","DSWL","DTWL","EMS","FEDEX","FEDEX_GJ","PANEX","FKD","GDEMS","GSD","GTO","GTSD",
                                             "HOTSCM","HPTEX","HFWL","ZHQKD","HLWL","hq568","HXLWL","HYLSD","JGSD","JIUYE","JJKY","JLDT","JTKD","JXD","JYKD","JYM","JYWL","FAST","QUICK","KYWL","LB","LHT","MHKD","MLWL","NEDA","PADTF","PCA",
                                            "PCA Express","QCKD","QFKD","UAPEX","QRT","RFD","RFEX","SUBIDA","SAD","SAWL","SBWL","SDWL","SF","SFWL","SHWL","ST","STO","STWL","SURE","HOAU","HHTT","TSSTO","UEQ",
                                            "WJWL","WXWL","XBWL","XFEX","XYT","XJ","UC","AMAZON","YADEX","YCWL","YD","YDH","YFEX","YFHEX","YFSD","YTKD","YTO","YXKD","YZPY","ZENY","ZJS","ZTE","ZTKY","ZTO","ZTWL","ZYWL"],
                                  
                                  forKeys: ["安信达快递","澳邮专线","北青小红帽","百福东方","百世快运","百世快递","CNPEX中邮快递","CCES快递","COE东方快递","城际快递","城市100","长沙创一","德邦","D速物流","大田物流","EMS","FEDEX联邦(国内件）","FEDEX联邦(国际件）","泛捷快递","飞康达","广东邮政","共速达","国通快递","高铁速递","鸿桥供应链","海派通物流公司","汇丰物流","汇强快递","HLWL","恒路物流","hq568","华强物流","HXLWL","华夏龙物流","好来运快递","京广速递","九曳供应链","佳吉快运","嘉里物流","捷特快递","急先达","晋越快递","加运美","佳怡物流","快捷速递","快客快递","跨越物流","龙邦快递","联昊通速递","民航快递","明亮物流","能达速递","平安达腾飞快递","PCA Express","全晨快递","全峰快递","全一快递","全日通快递","如风达","瑞丰速递","速必达物流","赛澳递","圣安物流","盛邦物流","上大物流","顺丰快递","盛丰物流","盛辉物流","速通物流","申通快递","速腾快递","速尔快递","天地华宇","天天快递","唐山申通","UEQ Express","万家物流","万象物流","新邦物流","信丰快递","希优特","新杰物流","优速快递","亚马逊物流","源安达快递","远成物流","韵达快递","义达国际物流","越丰物流","原飞航物流","亚风快递","运通快递","圆通速递", "亿翔快递","邮政平邮/小包","增益快递","宅急送","众通快递","中铁快运","中通速递","中铁物流","中邮物流"])
        

        
        
        let tabView = UITableView(frame: CGRect(x: 0, y: 130, width: ScreenW, height: ScreenH-130), style: UITableView.Style.plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tabView)
        
    }
    
    @objc func btnAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
}


extension EXPressCompony : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expressArray!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        cell?.textLabel?.text = expressArray![indexPath.row] as? String
        cell?.imageView?.image = UIImage(named: "HomeKuaidi")

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = expressArray?[indexPath.row] as! String
        selectStr = str
        self.delegate?.dismis(string: str)
        self.dismiss(animated: true, completion: nil)
    }

}
