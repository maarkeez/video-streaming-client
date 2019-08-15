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

    // MARK: - UI
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // MARK: - Properties
    private let reuseIdentifier = "myCollectionViewCell"
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    private var series : [Serie] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
       
        SerieSerivce.singleton().findAll().done { series in

            self.series.append(contentsOf: series)
            self.reloadDataInMainThread()
           
        }.catch { e in
            
            print("Error while retrieving series. Cause: " + e.localizedDescription)
            self.series.append(contentsOf: self.seriesPlaceholder())
            self.reloadDataInMainThread()
            
        }
        
    }

  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
        // let url = URL(string: "https://video-streaming-server.herokuapp.com/videos/minions_bomberos.mp4")!
        
        // playVideo(url: url)
    }
    
    private func seriesPlaceholder() -> [Serie] {
        var series : [Serie] = []
        for _ in 1...50{
            series.append(Serie(displayImage: #imageLiteral(resourceName: "no_image_available"), name: ""))
        }
        return series
    }
    
    private func reloadDataInMainThread(){
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
    }
    
    
    private func playVideo(url: URL) {
        
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
    }

}

extension VSCHomePageViewControler: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VCSCollectionViewCell
        cell.backgroundColor = .black
        cell.myImage.image = series[indexPath.row].displayImage
        cell.myTitle.text = series[indexPath.row].name
       
        cell.contentView.layer.cornerRadius = 3.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
}

extension VSCHomePageViewControler: UICollectionViewDelegateFlowLayout {
    // Layout size of a cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Create the layout with a given padding
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem * 0.60

        return CGSize(width: widthPerItem, height:heightPerItem )
    }
    
    // Spacing between cells, headers and footers
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // Spacing between each line of the layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left * 2.5
    }
}


extension VSCHomePageViewControler: UICollectionViewDelegate {
    
}
