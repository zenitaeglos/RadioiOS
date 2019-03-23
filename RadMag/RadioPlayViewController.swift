//
//  RadioPlayViewController.swift
//  RadMag
//
//  Created by Alejandro Martinez Montero on 23/03/2019.
//  Copyright © 2019 Alejandro Martinez Montero. All rights reserved.
//

import UIKit
import AVFoundation

class RadioPlayViewController: UIViewController {
    
    var dataToDisplay: RadioDescription?

    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var radioName: UILabel!
    @IBOutlet weak var radioImage: UIImageView!
    var radioPlayer: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        radioName.text = dataToDisplay?.name
        let url = URL(string: (dataToDisplay?.favicon)!)
        if let myUrl = url {
            let data = try? Data(contentsOf: myUrl)
            if let imageData = data {
                radioImage.image = UIImage(data: imageData)
            }
        }
        let radioUrl = URL(string: (dataToDisplay?.url)!)
        if let radioToPlayUrl = radioUrl {
            let playerItem = AVPlayerItem.init(url: radioToPlayUrl)
            radioPlayer = AVPlayer.init(playerItem: playerItem)
            radioPlayer?.play()
        }
    }
    

    @IBAction func playStopButtonClicked(_ sender: UIButton) {
        if playPauseButton.titleLabel?.text == "Pause" {
            playPauseButton.setTitle("Play", for: UIControl.State.normal)
            radioPlayer?.pause()
            playPauseButton.titleLabel?.text = "Play"
        }
        else {
            radioPlayer?.play()
            playPauseButton.setTitle("Pause", for: UIControl.State.normal)
        }
    }
}
