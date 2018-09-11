//
//  ViewController.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AlertViewDelegate {
    func show(animated: Bool) {
        
    }
    
    func dismiss(animated: Bool) {
        
    }
    
    var backgroundView = UIView()
    
    var containerView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let alertView = AlertView(title: "Errro",
                                  message: "if you remember, we have two variables defined on the top i.e backgroundView and dialogView. dialogView is the view that will contain the actual Alert content and backgroundView is the view behind the dialogView..",
                                  ok: "Ok",
                                  cancel: "Cancel")
        self.view.addSubview(alertView)
    }
    
}

