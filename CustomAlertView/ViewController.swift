//
//  ViewController.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showAlert2(_ sender: Any) {
        let alertView = AlertView(title: "Errro",
                                  message: "Currently we don't serve in this region.",
                                  ok: "Ok",
                                  cancel: "",target: self)
        //self.view.addSubview(alertView)
        alertView.show(animated: true)
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let alertView = AlertView(title: "Errro",
                                  message: "Currently we don't serve in this region.",
                                  ok: "Ok",
                                  cancel: "Cancel",target: self)
        //self.view.addSubview(alertView)
        alertView.show(animated: true)
    }
    
}
// MARK: - AlertView Delegate
extension ViewController: AlertViewDelegate {
    func alertView(alertView: AlertView, clickedButtonAtIndex buttonIndex: Int) {
        
    }

}

