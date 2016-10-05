//
//  ViewController.swift
//  WindowAlert
//
//  Created by Yaroslav Bondar on 05.10.16.
//  Copyright © 2016 SMediaLink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var coveringWindow: AlertWindow = {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "OrderTotalController") as! OrderTotalController
        controller.discountToShow = String(100500)
        let window = AlertWindow(controller: controller)
        return window
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        coveringWindow.show()
    }
}


class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBlur()
        addTapGesture()
    }
    

    func addBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubview(toBack: blurEffectView)
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        view.addGestureRecognizer(tapGesture)
    }
    
    func dismissPopup() {
//        rootViewController?.view.transform = CGAffineTransformIdentity
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.view.alpha = 0
            }, completion: { finished -> Void in
                self.view.isHidden = true
        })
        
        
    }
}
