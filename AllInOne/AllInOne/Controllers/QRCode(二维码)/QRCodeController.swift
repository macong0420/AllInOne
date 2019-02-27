//
//  QRCodeController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/25.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
let kInputViewH: CGFloat = 220

class QRCodeController: BaseViewController {

    
    var inputStr = ""
    
    lazy var inputTextView: UITextView = {
        let input = UITextView(frame: CGRect(x: 0, y:0, width: ScreenW-80, height: kInputViewH))
        input.backgroundColor = UIColor.clear
        input.keyboardType = .numberPad
        input.font = UIFont.systemFont(ofSize: 20)
        input.delegate = self
        input.becomeFirstResponder()
        return input
    }()
    
    lazy var inputContentView: BaseShadowView = {
        let view = BaseShadowView(frame: CGRect(x: kMagin, y: kTopNavViewH+kMagin, width: ScreenW-kMagin*2, height: kInputViewH))
        return view
    }()
    
    lazy var createBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("生成", for: UIControl.State.normal)
        btn.frame = CGRect(x: 40, y: kTopNavViewH + 40 + 40 + kInputViewH, width: ScreenW-80, height: 40)
        btn.isEnabled = true
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.init(hex: "#32384E")), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(createQRImag), for: UIControl.Event.touchUpInside)
        return btn
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.setTitle(title: "二维码生成")
        setupUI()
    }

    func setupUI() {
        
        self.view.addSubview(inputContentView)
        inputContentView.insertView(view: inputTextView)
        self.view.addSubview(createBtn)
    }
    
    func checkBtnStatus() {
        if inputStr.count > 0 {
            createBtn.isEnabled = true
        } else {
            createBtn.isEnabled = false
        }
    }
    
    @objc func inputChanged(input textField: UITextField) {
        inputStr = textField.text ?? ""
        checkBtnStatus()
    }
    
    @objc func createQRImag() {
        let qrcodeImgVc = QRCodeImageController.init(contenString: inputStr)
        self.present(qrcodeImgVc, animated: true, completion: nil)
    }

}


// UITextView 编辑
extension QRCodeController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        inputStr = textView.text ?? ""
        checkBtnStatus()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       
    }
}
