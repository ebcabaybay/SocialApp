//
//  ViewController.swift
//  SocialApp
//
//  Created by Spam C. on 2/3/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let main = LoginView()
        main.modalPresentationStyle = .fullScreen
        present(main, animated: true)
    }
}

