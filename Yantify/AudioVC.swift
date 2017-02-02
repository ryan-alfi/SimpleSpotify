//
//  AudioVC.swift
//  Yantify
//
//  Created by iMac on 2/2/17.
//  Copyright © 2017 Ari Fajrianda Alfi. All rights reserved.
//

import Foundation
import UIKit

class AudioVC: UIViewController {
    
    var image = UIImage()
    var mainSongTitle = String()
    
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    
    override func viewDidLoad() {
        songTitle.text = mainSongTitle
        
        background.image = image
        mainImageView.image = image
    }
}
