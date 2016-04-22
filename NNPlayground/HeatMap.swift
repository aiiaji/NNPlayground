//
//  HeatMap.swift
//  NNPlayground
//
//  Created by 杨培文 on 16/4/21.
//  Copyright © 2016年 杨培文. All rights reserved.
//

import UIKit
let SCALE = 3
class HeatMapView: UIView {
    let NUM_SHADES = 256
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLayer()
    }
    
    var backgroundLayer = CALayer()
    var dataLayer = CALayer()
    
    func initLayer(){
        backgroundLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        self.layer.insertSublayer(backgroundLayer, atIndex: 0)
        dataLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        self.layer.insertSublayer(dataLayer, atIndex: 1)
    }
    
    var img = UIImage()
    func setBackground(image:UIImage){
        self.img = image;
        backgroundLayer.contents = img.CGImage
        self.setNeedsDisplay()
    }
    
    var x:[[Double]] = []
    var y:[Double] = []
    
    func setData(x1:UnsafeMutablePointer<Double>, x2:UnsafeMutablePointer<Double>, y:UnsafeMutablePointer<Double>, size:Int){
        self.x = []
        self.y = []
        for i in 0..<size{
            self.x.append([x1[i], x2[i]])
            self.y.append(y[i])
        }
        dataLayer.sublayers = nil
        
        let width = Double(dataLayer.bounds.width / 2)
        let height = Double(dataLayer.bounds.height / 2)
        for i in 0..<x.count{
            var pathLayer = CAShapeLayer()
            var path = UIBezierPath(ovalInRect: CGRect(x: Double(width * x[i][0] + width)-1, y: Double(height * x[i][1] + height)-1, width: 7, height: 7))
            pathLayer.path = path.CGPath
            pathLayer.fillColor = white.CGColor
            dataLayer.addSublayer(pathLayer)
            
            pathLayer = CAShapeLayer()
            path = UIBezierPath(ovalInRect: CGRect(x: Double(width * x[i][0] + width), y: Double(height * x[i][1] + height), width: 5.0, height: 5.0))
            pathLayer.path = path.CGPath
            if y[i] > 0{
                pathLayer.fillColor = orange.CGColor
            }else{
                pathLayer.fillColor = blue.CGColor
            }
            dataLayer.addSublayer(pathLayer)
            
        }
        self.setNeedsDisplay()
    }
    
    let orange = UIColor(red: 245/256.0, green: 147/256.0, blue: 36/256.0, alpha: 1)
    let blue = UIColor(red: 8/256.0, green: 119/256.0, blue: 189/256.0, alpha: 1)
    let white = UIColor(red: 232/256.0, green: 234/256.0, blue: 235/256.0, alpha: 1)
    
}