//
//  QRCodeImageController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/2/20.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit
import CLToast

let imgViewW = ScreenW - kMagin*2



class QRCodeImageController: UIViewController {
    
    private var contentStr = ""
    
    //关闭按钮
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        let img = UIImage(named: "Close")!
        btn.setBackgroundImage(img, for: .normal)
        btn.titleLabel?.textColor = UIColor.black
        btn.frame = CGRect(x: 20, y: 40, width: img.size.width, height: img.size.height)
        btn.addTarget(self, action: #selector(closeAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private lazy var topNavView: CommonTopNavView = {
        let rect = CGRect(x: 0, y: 0, width: ScreenW, height: kTopNavViewH)
        let topView = CommonTopNavView(frame: rect, title: "二维码图片")
        return topView
    }()
    
    private lazy var qrcodeImgView: UIImageView = {
       let imgView = UIImageView()
        let imgViewY = kTopNavViewH + 40
        imgView.frame = CGRect(x: kMagin, y: imgViewY, width: imgViewW, height: imgViewW)
        return imgView
    }()
    
    private lazy var saveBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("保存到相册", for: UIControl.State.normal)
        btn.frame = CGRect(x: 40, y: kTopNavViewH + 40 + imgViewW + 20, width: ScreenW-80, height: 40)
        btn.layer.shadowColor = UIColor.init(hex: "#ececec").cgColor
        btn.layer.shadowOpacity = 0.9
        btn.layer.shadowRadius = 10
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.orange), for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage.imageWithColor(color: UIColor.groupTableViewBackground), for: UIControl.State.disabled)
        btn.addTarget(self, action: #selector(saveQRImag), for: UIControl.Event.touchUpInside)
        return btn
    }()

    init(contenString: String) {
        super.init(nibName: nil, bundle: nil)
        contentStr = contenString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topNavView)
        view.addSubview(closeBtn)
        view.addSubview(qrcodeImgView)
        view.addSubview(saveBtn)
        
        QRCodeUtil.setQRCodeToImageView(qrcodeImgView, contentStr)

    }
    
}



extension QRCodeImageController {
    
    //关闭
    @objc func closeAction() {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    @objc func saveQRImag() {
        let qrImage = qrcodeImgView.image as? UIImage
        
        if qrImage == nil {
            CLToast.cl_show(msg: "生成图片失败")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(qrImage!, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if let e = error as NSError? {
           
        } else {
            CLToast.cl_show(msg: "保存成功")
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    
}


