//
//  ViewController.swift
//  CoreMotionData
//
//  Created by Zhang xiaosong on 2018/5/17.
//  Copyright © 2018年 Zhang xiaosong. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

//    let lengthFormater = NSLength
    let pedometer = CMPedometer()
    
    let titleLabel = UILabel()
    let stepLabel = UILabel()
    
    /// MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initInterface()
        self.startStepMotion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /// MARK: - private methods
    
    /// 初始化子视图
    private func initInterface() {
        
        self.view.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0.0, y: 60.0, width: self.view.frame.size.width, height: 40.0)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.text = "计步"
        
        self.view.addSubview(stepLabel)
        stepLabel.frame = CGRect(x: 0.0, y: 100.0, width: self.view.frame.size.width, height: 200.0)
        stepLabel.numberOfLines = 0
        stepLabel.textColor = UIColor.blue
    }
    
    /// 开始计步
    private func startStepMotion() {
        pedometer.startUpdates(from: NSDate() as Date) { (data, error) in
            if (error == nil) {
                let distance = data?.distance?.doubleValue
                let time = data?.endDate.timeIntervalSince((data?.startDate)!) //秒
                let speed = distance! / time!
                let step = data?.numberOfSteps.intValue
                let labelStr = "距离 \(Double(distance!)),\n 时间 \(String(describing: time)),\n 速度 \(speed),\n 步数 \(String(describing: step))"
                DispatchQueue.main.async {
                    self.stepLabel.text = labelStr
                }
                
            }
        }
    }


}

