//
//  ProgressHud.swift
//  MyGithub
//
//  Created by Ehab Saifan on 8/15/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProgressHUD: NSObject {
    @discardableResult
    class func displayMessage(text: String?, fromView : UIView?, mode : MBProgressHUDMode = .text, delayTime : Double = 1.3, completion : (() -> Void)? = nil) -> MBProgressHUD?{
        
        if let fromView = fromView, let text = text {
            let hud = MBProgressHUD.showAdded(to: fromView, animated: true)
            hud.layer.zPosition = 1
            hud.mode = mode
            hud.detailsLabel.text = NSLocalizedString(text, comment: "")
            hud.detailsLabel.font = hud.label.font
            delay(delay: delayTime, closure: {() -> () in
                hud.hide(animated: true)
                if (completion != nil){
                    completion!()
                }
            })
            return hud
        }
        return nil
    }
    
    @discardableResult
    class func displayProgress(text: String?, fromView : UIView?, delay: Double = 90, completion : (() -> Void)? = nil) -> MBProgressHUD?{
        return self.displayMessage(text: text, fromView: fromView, mode: .indeterminate, delayTime: delay, completion: completion)
    }
    
    class func hidProgress(fromView: UIView?, animated: Bool = false) {
        if let view = fromView {
            MBProgressHUD.hide(for: view, animated: animated)
        }
    }
}

func delay(delay:Double, closure:@escaping ()->()) {
    let delay = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: delay) {
        closure()
    }
}

