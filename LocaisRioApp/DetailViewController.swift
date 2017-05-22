//
//  DetailViewController.swift
//  LocaisRioApp
//
//  Created by Ramon dos Santos on 14/05/17.
//  Copyright © 2017 Ebix American Latin. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //dados do TableViewController
    var nameString:String!
    var descriptionString:String!
    var imageString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        
        let imgURL = URL(string:imageString)
        let data = NSData(contentsOf:(imgURL)!)
        
        self.nameLabel.text = nameString
        self.descriptionLabel.text = descriptionString
        self.imgView.image = UIImage(data: data as! Data)
    }

}
