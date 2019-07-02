//
//  ViewController.swift
//  LoaderProgress
//
//  Created by Omar Alqabbani on 7/2/19.
//  Copyright © 2019 OmarALqabbani. All rights reserved.
//

import UIKit

let shapeLayer = CAShapeLayer()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        
        let shapeTrack = CAShapeLayer()
        shapeTrack.path = circularPath.cgPath
        shapeTrack.lineWidth = 10
        shapeTrack.strokeColor = UIColor.lightGray.cgColor
        shapeTrack.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapeTrack)
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClickOnView)))
        
    }
    
    @objc private func handleClickOnView(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = 2
        basicAnimation.toValue = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        
    }

}

