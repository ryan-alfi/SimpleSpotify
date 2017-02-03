//
//  AudioVC.swift
//  Yantify
//
//  Created by iMac on 2/2/17.
//  Copyright © 2017 Ari Fajrianda Alfi. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioVC: UIViewController {
    
    var image = UIImage()
    var mainSongTitle = String()
    var mainPreviewURL = String()
    
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    
    override func viewDidLoad() {
        songTitle.text = mainSongTitle
        
        background.image = image
        mainImageView.image = image
        
        downloadFileFromURL(url: URL(string: mainPreviewURL)!)
        
        playPauseBtn.setTitle("Pause", for: .normal)
    }
    
    func downloadFileFromURL(url: URL) {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (customURL, response, err) in
            
            self.play(url: customURL!)
            
        })
        
        downloadTask.resume()
    }
    
    func play(url: URL) {
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        }catch {
            print(error)
        }
    }
    
    @IBAction func pausePlay(_ sender: Any) {
        if player.isPlaying {
            player.pause()
            playPauseBtn.setTitle("Play", for: .normal)
        }else {
//            downloadFileFromURL(url: URL(string: mainPreviewURL)!)
            player.play()
            playPauseBtn.setTitle("Pause", for: .normal)
        }
    }
    
}
