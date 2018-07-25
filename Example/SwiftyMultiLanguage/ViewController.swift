//
//  ViewController.swift
//  SwiftyMultiLanguage
//
//  Created by Benny on 07/24/2018.
//  Copyright (c) 2018 Benny. All rights reserved.
//

import UIKit
import SwiftyMultiLanguage

class ViewController: UIViewController {
    
    var language : Language = Language()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        print(Language.getLanguage(language: "All Deal"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

