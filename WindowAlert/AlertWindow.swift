//
//  AlertWindow.swift
//  WindowAlert
//
//  Created by Yaroslav Bondar on 05.10.16.
//  Copyright © 2016 SMediaLink. All rights reserved.
//

import UIKit

protocol WindowControllerProtocol: class {
    var didCancel: () -> () { get set }
    var view: UIView! { get set }
}

final class AlertWindow: UIWindow {

    private let blurEffectView = UIVisualEffectView()
    private let blurEffect = UIBlurEffect(style: .light)
    private let minScale = CGAffineTransform(scaleX: 0.01, y: 0.01)
    
    convenience init(controller: UIViewController) {
        self.init(frame: controller.view.frame)
        rootViewController = controller
    }
    
    override var rootViewController: UIViewController? {
        didSet {
            guard let controller = rootViewController as? WindowControllerProtocol else { return }
            controller.didCancel = hide
            setupBlurView(frame: controller.view.bounds)
            setupWindowLevel()
        }
    }
    
    private func setupBlurView(frame: CGRect) {
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        sendSubview(toBack: blurEffectView)
    }
    
    private func setupWindowLevel() {
        guard let lastWindowLevel = UIApplication.shared.windows.last?.windowLevel else { return }
        windowLevel = lastWindowLevel + 1
    }
    
    private func hide() {
        rootViewController?.view.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut,
            animations: {() -> Void in
                self.alpha = 0
                self.blurEffectView.effect = nil
                self.rootViewController?.view.transform = self.minScale
            },
            completion: { finished -> Void in
                self.isHidden = true
            }
        )
    }
    
    func show() {
        alpha = 0
        isHidden = false
        rootViewController?.view.transform = minScale
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.alpha = 1
            self.blurEffectView.effect = self.blurEffect
            self.rootViewController?.view.transform = CGAffineTransform.identity
            }, completion: nil)
    }
}
