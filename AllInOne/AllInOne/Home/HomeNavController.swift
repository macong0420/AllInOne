//
//  HomeNavController.swift
//  AllInOne
//
//  Created by 马聪聪 on 2019/1/17.
//  Copyright © 2019 马聪聪. All rights reserved.
//

import UIKit

class HomeNavController: UINavigationController  {

    ///属性
    var topView : HomeTopView?
    var collectionView :UICollectionView?
    var itemTitleArray : NSArray?
    var itemIconArray : NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //数据初始化
        initData()
        //控件初始化
        setupUI()
    }
    
    //视图将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置导航栏背景透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //视图将要消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //重置导航栏背景
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
}


extension HomeNavController : UICollectionViewDelegate,UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemTitleArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        cell.backgroundColor = UIColor.white
        cell.iconImg = itemIconArray![indexPath.row]  as? String
        cell.title = itemTitleArray![indexPath.row] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.row
        
        if item == 0 {
            let calenderVC = CalendarController()
            self.present(calenderVC, animated: true) {
                
            }
        } else if item == 1 {
            let qrCodeVC = QRCodeController()
            self.present(qrCodeVC, animated: true) {
                
            }
        } else if item == 2 {
            
        } else if item == 4 {
            let expressVC = EXPressController()
            self.present(expressVC, animated: true, completion: {
            })
        }
    }
}


///私有方法
extension HomeNavController {
    
    private func setupUI() {
        //修改导航栏标题文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        //修改导航栏按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        //设置视图的背景图片（自动拉伸）
//        self.view.layer.contents = UIImage(named:"back")!.cgImage
        
        topView = HomeTopView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 340/2))
        self.view.addSubview(topView!)
        collectionView = createCollectionView()
        self.view.addSubview(collectionView!)
    }                    
    
    private func initData() {
        itemTitleArray = ["万年历","二维码生成","精美图片","天气预报","快递查询","手机归属地","wifi密码查看"]
        itemIconArray = ["HomeCalernser","HomeQRCode","HomeBuatufulImg","HomeWeather","HomeKuaidi","HomePhone","wifi"]

    }
    
    
    private func createCollectionView () -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let freame = CGRect(x: 0, y: 340/2, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let collectionView = UICollectionView(frame: freame, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/3-1, height: UIScreen.main.bounds.size.width/3*1.25)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }
    
    
}
