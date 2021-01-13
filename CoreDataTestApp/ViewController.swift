//
//  ViewController.swift
//  CoreDataTestApp
//
//  Created by Brotecs on 7/1/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }


}

