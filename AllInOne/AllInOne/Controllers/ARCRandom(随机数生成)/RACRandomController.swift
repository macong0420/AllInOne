//
//  RACRandomController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/22.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import CLToast

class RACRandomController: BaseViewController {

    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "请输入随机数范围"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 20)
        label.frame = CGRect(x: kMagin, y: kTopNavViewH+40, width: ScreenW-kMagin*2, height: 20)
        return label
    }()
    
    private lazy var firstShadowView: BaseShadowView = {
        let view = BaseShadowView(frame: CGRect(x: kMagin, y: kTopNavViewH+40+40, width: inputW, height: 60))
        return view
    }()
    
    private lazy var firstInput: UITextField = {
        let input = UITextField()
        input.delegate = self
        input.keyboardType = .numberPad
        input.backgroundColor = UIColor.clear
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        input.leftViewMode = .always
        input.addTarget(self, action: #selector(firstInputChange(iputField:)), for: UIControl.Event.editingChanged)
        input.text = "1"
        return input
    }()
    
    private lazy var secondShadowView: BaseShadowView = {
        let view = BaseShadowView(frame: CGRect(x: kMagin+inputW+100, y: kTopNavViewH+40+40, width: inputW, height: 60))
        return view
    }()
    
    private lazy var secondInput: UITextField = {
        let input = UITextField()
        input.delegate = self
        input.keyboardType = .numberPad
        input.backgroundColor = UIColor.clear
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        input .addTarget(self, action: #selector(secondInputChange(iputField:)), for: UIControl.Event.editingChanged)
        input.leftViewMode = .always
        input.text = "100"
        return input
    }()
    
    private lazy var RandomLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.init(hex: "#32384E")
        label.font = UIFont.systemFont(ofSize: 80)
        label.textAlignment = .center
        label.sizeToFit()
        label.frame = CGRect(x: kMagin, y: kTopNavViewH+40+40, width: ScreenW-kMagin*2, height: ScreenH-(kTopNavViewH+40+40+40+20)-60)
        return label
    }()
    
    lazy var caculateBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("生成", for: UIControl.State.normal)
        btn.frame = CGRect(x: 40, y: ScreenH - 20 - 40, width: ScreenW-80, height: 40)
        btn.isEnabled = true
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.init(hex: "#32384E")), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(caculateRandom), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    
    
    
    var firstNum: UInt32 = 1
    var secondNUm: UInt32 = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topNavView.setTitle(title: "随机数生成")
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tipsLabel)
        view.addSubview(firstShadowView)
        view.addSubview(secondShadowView)
        view.addSubview(caculateBtn)
        view.addSubview(RandomLabel)
        
        firstInput.frame = CGRect(x: 2, y: 2, width: firstShadowView.bounds.size.width-4, height: firstShadowView.bounds.size.height-4)
        secondInput.frame = CGRect(x: 2, y: 2, width: secondShadowView.bounds.size.width-4, height: secondShadowView.bounds.size.height-4)
        firstShadowView.addSubview(firstInput)
        secondShadowView.addSubview(secondInput)
    }
    
    
    @objc func firstInputChange(iputField: UITextField) {
        
        if iputField.text == "" {
            firstNum = 0
        } else {
            if isPurnInt(string: iputField.text!),iputField.text!.count <= 7 {
                firstNum = UInt32(iputField.text!)!
            } else {
                CLToast.cl_show(msg: "仅支持百万以下数字")
            }
        }
    }
    
    @objc func secondInputChange(iputField: UITextField) {
        if iputField.text == "" {
            secondNUm = 0
        } else {
            if isPurnInt(string: iputField.text!),iputField.text!.count <= 7 {
                secondNUm = UInt32(iputField.text!)!
            } else {
                CLToast.cl_show(msg: "仅支持百万以下数字")
            }

        }
    }
    
    @objc func caculateRandom() {
        
        firstInput.resignFirstResponder()
        secondInput.resignFirstResponder()
        
        var ran: UInt32 = 0
        if firstNum > secondNUm {
            ran = arc4random() % (firstNum - secondNUm) + firstNum
        } else if firstNum == secondNUm {
            ran = firstNum
        } else {
            ran = arc4random() % (secondNUm - firstNum) + firstNum
        }
        RandomLabel.text = "\(ran)"
        
    }
    
    func isPurnInt(string: String) -> Bool {
        
        let scan: Scanner = Scanner(string: string)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
        
    }
    
}

extension RACRandomController: UITextFieldDelegate {
    
    
}
