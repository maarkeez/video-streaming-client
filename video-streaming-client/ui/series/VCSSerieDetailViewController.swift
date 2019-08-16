//
//  VCSSerieDetailViewController.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 16/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VCSSerieDetailViewController: UIViewController {

    // MARK: - UI
    @IBOutlet weak var myDisplayImage: UIImageView!
    @IBOutlet weak var myTable: UITableView!
    
    // MARK: - Properties
    var mySerie: Serie?
    var seasons : [Season] = []
    
    private let reuseIdentifier = "serieDetailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = mySerie?.name
        self.navigationItem.backBarButtonItem?.title = ""
        myTable.dataSource = self
        myTable.delegate = self
        myDisplayImage.image = mySerie?.displayImage
        populateSeasons()
    }
    
    private func populateSeasons() {
        let videoLink = "http://10.10.1.117:8080/videos/minions_bomberos.mp4"
        for _ in 1...3 {
            var episodes : [Episode] = []
            episodes.append(Episode(title: "Episode 1", videoLink: videoLink))
            episodes.append(Episode(title: "Episode 2", videoLink: videoLink))
            episodes.append(Episode(title: "Episode 3", videoLink: videoLink))
            seasons.append(Season(episodes: episodes))
        }
    }
    
    private func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true) { vc.player?.play() }
    }

}


extension VCSSerieDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons[section].episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VCSSerieDetailTableViewCell
        cell.myEpisodeTitle.text = seasons[indexPath.section].episodes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section + 1)"
    }
    
}

extension VCSSerieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playVideo(url: URL(string: seasons[indexPath.section].episodes[indexPath.row].videoLink)!)
    }
}
