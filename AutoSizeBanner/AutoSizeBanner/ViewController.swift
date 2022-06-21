//
//  ViewController.swift
//  AutoSizeBanner
//
//  Created by ac on 2022/6/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.layer.cornerRadius = 240
//        self.view.layer.masksToBounds
    }
    @IBAction func addLineEvent(_ sender: Any) {
        testLabel.text = testLabel.text?.appending("\nlabel\nlabel\nlabel\nlabel\nlabel")
    }
}

