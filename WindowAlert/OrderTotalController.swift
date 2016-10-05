//
//  OrderTotalController.swift
//  OrderApp-Customer-iOS
//
//  Created by Yaroslav Bondar on 06.09.16.
//  Copyright © 2016 SMediaLink. All rights reserved.
//

import UIKit



class OrderTotalController: UIViewController, WindowControllerProtocol {
    
    @IBOutlet weak var discountLabel: UILabel!
    var discountToShow = ""
    
    var didCancel: () -> () = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discountLabel.text = discountToShow + " NIS"
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        didCancel()
    }
}
