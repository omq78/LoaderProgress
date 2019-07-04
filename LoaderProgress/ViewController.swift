//
//  ViewController.swift
//  LoaderProgress
//
//  Created by Omar Alqabbani on 7/2/19.
//  Copyright © 2019 OmarALqabbani. All rights reserved.
//

import UIKit

var shapeLayer: CAShapeLayer!
var shapeTrack: CAShapeLayer!
var bouncingLayer: CAShapeLayer!

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    let downloadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Start"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download Completed")
    }
    

    func circleLayer(fillColor: UIColor, strokeColor: UIColor) -> CAShapeLayer {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        let layer =  CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.fillColor = fillColor.cgColor
        layer.strokeColor = strokeColor.cgColor
        layer.lineCap = .round
        layer.lineWidth = 20
        layer.position = view.center
        return layer
    }
    
    fileprivate func setupViewComponents() {
//        label
        downloadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        downloadLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        downloadLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor

        
//        shape layer
        shapeLayer = circleLayer(fillColor: UIColor.clear, strokeColor: UIColor.outlineStrokeColor)
        shapeLayer.strokeEnd = 0
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
//        shape track
        shapeTrack = circleLayer(fillColor: UIColor.clear, strokeColor: UIColor.trackStrokeColor)
        
//        bouncing layer
        bouncingLayer = circleLayer(fillColor: UIColor.clear, strokeColor: UIColor.pulsatingFillColor)
        pulsatingAnimation()
        
        
//        add view components
        view.layer.addSublayer(bouncingLayer)
        view.layer.addSublayer(shapeTrack)
        view.layer.addSublayer(shapeLayer)
        view.addSubview(downloadLabel)
        setupViewComponents()

//        user action
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClickOnView)))
        setNotifications()
        
    }
    
    private func setNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(pulsatingAnimation), name: UIApplication.willEnterForegroundNotification
            , object: nil)
    }
    
    @objc private func pulsatingAnimation(){
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.toValue = 1.2
        anim.duration = 0.5
        anim.autoreverses = true
        anim.repeatCount = Float.infinity
        anim.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        bouncingLayer.add(anim, forKey: "pulsing")
    }
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    @objc private func handleClickOnView(){
        startDownloadURL()
//        animateCircle()
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            let percentageLabel = Int(percentage * 100)
            self.downloadLabel.text = "\(percentageLabel)%"
            shapeLayer.strokeEnd = percentage
        }
    }
    
    private func startDownloadURL(){
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlsession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let urlVid = URL(string: urlString) else {return}
        let downloadTask = urlsession.downloadTask(with: urlVid)
        downloadTask.resume()
    }
}

