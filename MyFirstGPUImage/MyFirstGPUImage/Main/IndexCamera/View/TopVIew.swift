//
//  topVIew.swift
//  MyFirstGPUImage
//
//  Created by LiuYong on 2018/8/10.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD

protocol topViewDelegate{
    func  turnScale()
    func  turnCamera()
    func  flashMode()
    func  liveMode()
}


class TopView: UIView {
    
    let widthofme:CGFloat = 50
    //MARK: - lazy loading
    //  转换摄像头
    lazy var turnCameraButton:UIButton = {
        var btn = UIButton()
        btn.layer.cornerRadius = widthofme/2
        btn.setImage(#imageLiteral(resourceName: "转换"), for: .normal)
        btn.addTarget(self, action: #selector(self.turnCamera(_:)), for: .touchUpInside)
        return btn
    }()
    //    转换拍照比例
    lazy var turnScaleButton:UIButton = {
        var btn = UIButton()
        btn.layer.cornerRadius = widthofme/2
        btn.setImage(#imageLiteral(resourceName: "屏幕比例"), for: .normal)
        btn.addTarget(self, action: #selector(turnScale), for: .touchUpInside)
        return btn
    }()
    lazy var flashButton:UIButton = {
        var btn = UIButton()
        btn.layer.cornerRadius = widthofme/2
        btn.setImage(#imageLiteral(resourceName: "闪光灯关闭"), for: .normal)
        btn.addTarget(self, action: #selector(self.flashMode(btn:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var liveButton:UIButton = {
        var btn = UIButton()
        btn.layer.cornerRadius = widthofme/2
        btn.setImage(#imageLiteral(resourceName: "live"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "live1"), for: .selected)
        btn.addTarget(self, action: #selector(self.liveMode(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var liveCounter:UILabel = {
        var btn = UILabel()
        btn.textColor = UIColor.white
        return btn
    }()
    
    
    
    //Propoty，按钮点击的代理
    
    var delegate:topViewDelegate?
    
    
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        self.addSubview(turnCameraButton)
        self.addSubview(turnScaleButton)
        self.addSubview(flashButton)
        self.addSubview(liveButton)
        self.addSubview(liveCounter)
        let widthOfTop:CGFloat = 30
        turnScaleButton.snp.makeConstraints({
            make in
            make.width.height.equalTo(widthOfTop)
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(15)
        })
        
        turnCameraButton.snp.makeConstraints({
            make in
            make.width.height.equalTo(widthOfTop)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(15)
        })
        
        flashButton.snp.makeConstraints({
            make in
            make.width.height.equalTo(widthOfTop)
            make.left.equalTo(turnScaleButton.snp.right).offset(20)
            make.top.equalToSuperview().offset(15)
        })
        liveButton.snp.makeConstraints({
            make in
            make.width.height.equalTo(widthOfTop)
            make.right.equalTo(turnCameraButton.snp.left).offset(-20)
            make.top.equalToSuperview().offset(15)
            
        })
        liveCounter.snp.makeConstraints({
            make in
            make.width.height.equalTo(widthOfTop)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //按钮点击
    
    @objc func turnScale(){
        delegate?.turnScale()
    }
    
    @objc func flashMode(btn:UIButton){
        btn.isSelected = !btn.isSelected
        delegate?.flashMode()
    }

    @objc func turnCamera(_ btn:UIButton){
        delegate?.turnCamera()
    }
    @objc func pushVideo(){
    }
    @objc func liveMode(_ btn:UIButton){
        
        let deviceName = UIDevice.current.modelName
        if deviceName == "iPhone 5c" || deviceName == "iPhone 5s" || deviceName == "iPhone 4s" || deviceName == "iPhone "{
            ProgressHUD.showError("当前设备不支持LivePhoto")
        }else{
            btn.isSelected = !btn.isSelected
            delegate?.liveMode()
        }
    }
    
    func setCounter(text:String){
        DispatchQueue.main.async {
            self.liveCounter.text = text
        }
    }
    
    
}
