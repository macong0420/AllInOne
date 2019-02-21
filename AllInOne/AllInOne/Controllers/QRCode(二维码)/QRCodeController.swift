//
//  QRCodeController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/25.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class QRCodeController: UIViewController {

    
    var inputStr = ""
    
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
        let topView = CommonTopNavView(frame: rect, title: "二维码生成")
        return topView
    }()
    
    lazy var inputField: UITextField = {
        let input = UITextField(frame: CGRect(x: 40, y: kTopNavViewH + 40, width: ScreenW-80, height: 40))
        input.layer.shadowColor = UIColor.init(hex: "#ececec").cgColor
        input.layer.shadowOpacity = 0.9
        input.layer.shadowRadius = 10
        input.backgroundColor = UIColor.white
        input.keyboardType = .numberPad
        input.placeholder = "请输入您要生成二维码的内容"
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        input.leftViewMode = .always
        input.becomeFirstResponder()
        input.addTarget(self, action: #selector(inputChanged(input:)), for: UIControl.Event.editingChanged)
        return input
    }()
    
    lazy var createBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("生成", for: UIControl.State.normal)
        btn.frame = CGRect(x: 40, y: kTopNavViewH + 40 + 40 + 40, width: ScreenW-80, height: 40)
        btn.isEnabled = false
        btn.layer.shadowColor = UIColor.init(hex: "#ececec").cgColor
        btn.layer.shadowOpacity = 0.9
        btn.layer.shadowRadius = 10
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.orange), for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.groupTableViewBackground), for: UIControl.State.disabled)
        btn.addTarget(self, action: #selector(createQRImag), for: UIControl.Event.touchUpInside)
        return btn
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(createBtn)
        self.view.addSubview(topNavView)
        self.view.addSubview(inputField)
        self.view.addSubview(closeBtn)
    }
    
    @objc func inputChanged(input textField: UITextField) {
        inputStr = textField.text ?? ""
        checkBtnStatus()
    }
    
    @objc func createQRImag() {
        let qrcodeImgVc = QRCodeImageController.init(contenString: inputStr)
//        self.navigationController?.pushViewController(qrcodeImgVc, animated: true)
        self.present(qrcodeImgVc, animated: true, completion: nil)
    }
    
    func checkBtnStatus() {
        if inputStr.count > 0 {
            createBtn.isEnabled = true
        } else {
            createBtn.isEnabled = false
        }
    }
    
    //关闭
    @objc func closeAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
    

}
