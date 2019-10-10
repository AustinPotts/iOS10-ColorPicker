//
//  ViewController.swift
//  iOS10-ColorPicker
//
//  Created by Austin Potts on 10/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorPicker: ColorPicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func changeColor(_ sender: Any) {
        view.backgroundColor = colorPicker.selectedColor
    }
}

