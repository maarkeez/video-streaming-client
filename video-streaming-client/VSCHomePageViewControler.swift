//
//  ViewController.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 14/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VSCHomePageViewControler : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
        let url = URL(string: "https://video-streaming-server.herokuapp.com/videos/minions_bomberos.mp4")!
        
        playVideo(url: url)
    }
    
    func playVideo(url: URL) {
        
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
    }

}

