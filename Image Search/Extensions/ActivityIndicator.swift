//
//  ActivityIndicator.swift
//  Image Search
//
//  Created by Alex Paul on 2/27/22.
//

import UIKit

fileprivate var activityView: UIView?

extension UIViewController{
    func startActivityIndicator(){
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
        
    }
    
    func endActivityIndicator(){
        activityView?.removeFromSuperview()
        activityView = nil
    }
}
