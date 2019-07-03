//
//  ViewController.swift
//  LoaderProgress
//
//  Created by Omar Alqabbani on 7/2/19.
//  Copyright © 2019 OmarALqabbani. All rights reserved.
//

import UIKit

let shapeLayer = CAShapeLayer()

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    let downloadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.text = "Start"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download Completed")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        // shape layer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        shapeLayer.position = view.center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        // shape track
        let shapeTrack = CAShapeLayer()
        shapeTrack.path = circularPath.cgPath
        shapeTrack.lineWidth = 10
        shapeTrack.strokeColor = UIColor.lightGray.cgColor
        shapeTrack.fillColor = UIColor.clear.cgColor
        shapeTrack.position = view.center
        
        
        // add them all
        view.layer.addSublayer(shapeTrack)
        view.layer.addSublayer(shapeLayer)
        view.addSubview(downloadLabel)
        
        // label
        downloadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        downloadLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        downloadLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // user action
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClickOnView)))
        
    }
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = 2
        basicAnimation.toValue = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
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

