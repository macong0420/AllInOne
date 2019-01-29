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
    
    lazy var inputField: UITextField = {
        let input = UITextField(frame: CGRect(x: 40, y: 130, width: ScreenW-80, height: 40))
        input.layer.cornerRadius = 5
        input.layer.masksToBounds = true
        input.layer.borderColor = UIColor.gray.cgColor
        input.layer.borderWidth = 1
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
        btn.frame = CGRect(x: 40, y: 190, width: ScreenW-80, height: 40)
        btn.layer.cornerRadius = 5
        btn.isEnabled = false
        btn.layer.masksToBounds = true
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.orange), for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.groupTableViewBackground), for: UIControl.State.disabled)
        btn.addTarget(self, action: #selector(createQRImag(input:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
//    lazy var qrImgView: UIImageView = {
//        let imgView = UIImageView(frame: CGRect(x: 20, y: 250, width: ScreenW-80, height: ScreenW-80))
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(createBtn)
        self.view.addSubview(inputField)
        self.view.addSubview(closeBtn)
    }
    
    @objc func inputChanged(input textField: UITextField) {
        inputStr = textField.text ?? ""
        checkBtnStatus()
    }
    
    @objc func createQRImag(input: String) {
//        QRCodeUtil.setQRCodeToImageView(<#T##imageView: UIImageView?##UIImageView?#>, input)
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
