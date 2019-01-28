//
//  ScanController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/28.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import HRQRCodeScanTool

protocol ScanDelegate {
    func getScanInfo(info: String)
}

class ScanController: UIViewController {
    
    var delegate: ScanDelegate?
    
    //关闭按钮
    lazy var closeBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setBackgroundImage(UIImage(named: "ScanBack"), for: UIControl.State.normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: 20, y: 40, width: 40, height: 40)
        btn.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HRQRCodeScanTool.shared.delegate = self
        HRQRCodeScanTool.shared.beginScanInView(view: self.view)
        
        self.view.addSubview(closeBtn)
        
    }
    
    //关闭
    @objc func closeAction() {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                
            }
        }
    }

}

extension ScanController: HRQRCodeScanToolDelegate {
    
    //----------------扫描代理
    func scanQRCodeFaild(error: HRQRCodeTooError) {
        print(error)
    }
    
    func scanQRCodeSuccess(resultStrs: [String]) {
        print(resultStrs.first)
        self.delegate?.getScanInfo(info: resultStrs.first ?? "")
        HRQRCodeScanTool.shared.stopScan()
        
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                
            }
        }
        
        
    }
}
