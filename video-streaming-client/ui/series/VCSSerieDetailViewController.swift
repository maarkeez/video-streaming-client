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
    
    private let reuseIdentifier = "serieDetailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = mySerie?.name
        self.navigationItem.backBarButtonItem?.title = ""
        myTable.dataSource = self
        myTable.delegate = self
        myDisplayImage.image = mySerie?.displayImage
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
        return mySerie?.seasons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySerie?.seasons[section].episodes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VCSSerieDetailTableViewCell
        cell.myEpisodeTitle.text = mySerie?.seasons[indexPath.section].episodes[indexPath.row].title
        cell.changeSelectedBackgroundColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section + 1)"
    }
    
}

extension VCSSerieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let relativeVideoUrl = mySerie?.seasons[indexPath.section].episodes[indexPath.row].videoLink {
            let urlStr = SerieClient.singleton().toUrl(relativeVideoUrl)
            playVideo(url: URL(string: urlStr)!)
        }
    }
}
