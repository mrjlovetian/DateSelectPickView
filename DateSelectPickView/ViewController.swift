//
//  ViewController.swift
//  DateSelectPickView
//
//  Created by Mr on 2017/9/7.
//  Copyright © 2017年 Mr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pickView = DatePickView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.backgroundColor = .orange
        btn.setTitle("点击", for: .normal)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func click() -> () {
        
        pickView.show({ (showDateStr:String, realDateStr:String) in
            
        }) { 
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

