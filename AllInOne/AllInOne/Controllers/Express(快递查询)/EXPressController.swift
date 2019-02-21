//
//  EXPressController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/18.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import HRQRCodeScanTool
import CLToast

class EXPressController: UIViewController {

    var expressCodeStr : String?
    var expressValueStr = ""
    var logisticCode = "" //快递单号
    var expressModelArr = [ExpressModel]()

    
    //关闭按钮
    lazy var closeBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        let img = UIImage(named: "Close")!
        btn.setBackgroundImage(img, for: .normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: 20, y: 40, width: img.size.width, height: img.size.height)
        btn.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var topNavView: CommonTopNavView = {
        let rect = CGRect(x: 0, y: 0, width: ScreenW, height: kTopNavViewH)
        let topView = CommonTopNavView(frame: rect, title: "快递查询")
        return topView
    }()
    
    //扫码
    lazy var scanBtn: UIButton = {
       let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("", for: UIControl.State.normal)
        btn.setImage(UIImage(named: "ScanCode"), for: UIControl.State.normal)
        btn.frame = CGRect(x: ScreenW-kLefeMagin-30, y: 100, width: 40, height: 40)
        btn.addTarget(self, action: #selector(scanAcrion), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    //单号输入框
    lazy var expressCodeInputField: UITextField = {
        let textfield = UITextField()
        textfield.delegate = self
        textfield.layer.shadowColor = UIColor.init(hex: "#ececec").cgColor
        textfield.layer.shadowOpacity = 0.9
        textfield.layer.shadowRadius = 10
        textfield.backgroundColor = UIColor.white
        textfield.keyboardType = .numberPad
        textfield.placeholder = "请输入您的快递单号"
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = .always
        textfield.addTarget(self, action: #selector(expressCodeInputChanged(input:)), for: UIControl.Event.editingChanged)
        return textfield
    }()
    
    //选择快递公司
    lazy var expressSelcteBtn: UIButton = {
        let btn  = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("请选择快递公司", for: UIControl.State.normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btn.layer.shadowColor = UIColor.init(hex: "#ececec").cgColor
        btn.layer.shadowOpacity = 0.9
        btn.layer.shadowRadius = 10
        btn.addTarget(self, action: #selector(expressSelcteBtnAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    //查询按钮
    lazy var checkBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("查询", for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.orange), for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.groupTableViewBackground), for: UIControl.State.disabled)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(checkBtnAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    //物流信息tableview
    lazy var expressTablvew: UITableView = {
        let tableview = UITableView(frame: CGRect(x: 0, y:320 , width: ScreenW, height: ScreenH-320), style: UITableView.Style.plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isHidden = true
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:"expressTablvewcell")
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


extension EXPressController {
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(topNavView)
        self.view.addSubview(closeBtn)
        self.view.addSubview(scanBtn)
        self.view.addSubview(expressCodeInputField)
        self.view.addSubview(expressSelcteBtn)
        self.view.addSubview(checkBtn)
        self.view.addSubview(expressTablvew)
        
        expressCodeInputField.snp.makeConstraints { (make) in
            make.top.equalTo(topNavView.snp.bottom).offset(40)
            make.left.equalTo(closeBtn.snp.left)
            make.height.equalTo(60)
            make.right.equalTo(-40)
        }
        
        expressSelcteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(expressCodeInputField.snp.bottom).offset(20)
            make.left.equalTo(closeBtn.snp.left)
            make.height.equalTo(60)
            make.right.equalTo(-40)
        }
        
        checkBtn.snp.makeConstraints { (make) in
            make.top.equalTo(expressSelcteBtn.snp.bottom).offset(20)
            make.left.equalTo(closeBtn.snp.left)
            make.height.equalTo(40)
            make.right.equalTo(-40)
        }
        
        expressTablvew.snp.makeConstraints { (make) in
            make.top.equalTo(checkBtn.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    //检测查询按钮状态
    private func checkSearchBtnStatus() {
        
        if logisticCode.count > 0, expressValueStr.count > 0 {
            checkBtn.isEnabled = true
        } else {
            checkBtn.isEnabled = false
        }

    }
    
    //关闭
    @objc func closeAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    @objc func scanAcrion() {
        
        let scanVC = ScanController()
        scanVC.delegate = self
        self.present(scanVC, animated: true, completion: {

        })
        
    }
    
    @objc func expressSelcteBtnAction() {
        
        let conpenyVC = EXPressCompony()
        conpenyVC.delegate = self as EXPressComponyDelegate
        
        self.present(conpenyVC, animated: true) {
            
        }
    }
    
    @objc func expressCodeInputChanged(input textField: UITextField) {
        logisticCode = textField.text ?? ""
        checkSearchBtnStatus()
    }
    
    ///真正去查询
    @objc func checkBtnAction() {
        
        self.expressModelArr.removeAll()
        
        let expressAPI = "http://www.kuaidi100.com/query"
        let detailStr = "&id=1&valicode=&temp="
        let expressQuestStr = expressAPI + "?type=" + expressCodeStr! + "&postid=" + logisticCode + detailStr
        
        NetWorkTools.postRequest(urlString: expressQuestStr, parameters: [:] as [String : Any]) { (result) in
            guard let resultDict = result as? [String : NSObject] else {
                CLToast.cl_show(msg: "暂未查询到物流信息! \n\n请检测单号或快递公司后重试")
                return
                
            }
            //根据data的Key 取出数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                CLToast.cl_show(msg: "暂未查询到物流信息! \n\n请检测单号或快递公司后重试")
                return
            }
            
            for dict in dataArray {
                let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
                let expressModel = try! JSONDecoder().decode(ExpressModel.self, from: data)
                self.expressModelArr.append(expressModel)
            }
            
            if self.expressModelArr.count > 0 {
                self.expressTablvew.reloadData()
            } else {
                CLToast.cl_show(msg: "暂未查询到物流信息! \n\n请检测单号或快递公司后重试")
            }
        }
    }
}

extension EXPressController: UITextFieldDelegate,EXPressComponyDelegate,UITableViewDelegate,UITableViewDataSource,ScanDelegate {
    
    func getScanInfo(info: String) {
        if info.count > 0 {
            logisticCode = info
            expressCodeInputField.text = ""
            expressCodeInputField.text = info
            
        }
    }
    
    //----------------UITextFieldDelegate---------------
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func dismis(expressValue: String, expressCode: String) {
        expressSelcteBtn.setTitle(expressValue, for: UIControl.State.normal)
        let expressC = expressCode
        expressCodeStr = expressC
        
        let valueStr = expressValue
        expressValueStr = valueStr
        
        checkSearchBtnStatus()
    }
    
    //----------------UITextFieldDelegate---------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expressModelArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expressTablvewcell")
        cell?.textLabel?.numberOfLines = 0
        let model = expressModelArr[indexPath.row]
        if expressModelArr.count > 0 {
           expressTablvew.isHidden = false
        }
        cell?.textLabel?.text = model.context
        return cell ?? UITableViewCell()
    }
}

///----------快递公司选择控制器-------

///代理 反向传值
protocol EXPressComponyDelegate {
    func dismis(expressValue:String,expressCode:String)
}


class EXPressCompony: UIViewController {
    
    var selectStr: String?
    var delegate: EXPressComponyDelegate?

    
    
    var expressCodeArr: [String] = ["shunfeng","shentong","shentong","yuantong","zhongtong","huitongkuaidi","yunda","yundaexus","youzhengguonei","youzhengguoji","ems","debangwuliu","ems","emsguoji","fedex","fedexus","fedexuk"]
    var expressValueArr: [String] = ["顺丰速运","申通快递","申通E物流","圆通速递","中通快递","百世快递","韵达快递","韵达美国件","邮政国内","邮政国际","邮政EMS速递","德邦","EMS快递查询","EMS国际快递查询","FedEx快递查询","FedEx美国","FedEx英国"]

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
        return expressCodeArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = expressValueArr[indexPath.row]
        cell?.imageView?.image = UIImage(named: "HomeKuaidi")

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = expressValueArr[indexPath.row]
        let codeStr = expressCodeArr[indexPath.row]
        selectStr = str
        self.delegate?.dismis(expressValue: str, expressCode: codeStr)
        self.dismiss(animated: true, completion: nil)
    }

}
