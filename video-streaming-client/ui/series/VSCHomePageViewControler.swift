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
        cell.backgroundColor = myCollectionView.backgroundColor
       
        cell.myTitle.text = series[indexPath.row].name
        let displayImage = series[indexPath.row].displayImage
        
        let outerView = cell.myView!
        outerView.clipsToBounds = false
        outerView.layer.frame.size.height = cell.layer.frame.size.height * 0.60
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.3
        outerView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        outerView.layer.shadowRadius = 5
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 5).cgPath
        
        let myImage = UIImageView(frame: outerView.bounds)
        myImage.layer.cornerRadius = 10
        myImage.layer.borderWidth = 1.0
        myImage.layer.borderColor = UIColor.clear.cgColor
        myImage.layer.masksToBounds = true
        myImage.layer.frame.size.width = cell.layer.frame.size.width
        myImage.contentMode = .scaleAspectFit
        myImage.image = displayImage
    
        outerView.addSubview(myImage)
        
        
        
        /*
        var rect = cell.myImage.frame
        rect.size.height = rect.size.height * 0.60
       
        cell.myImage.frame = rect
        
        cell.myImage.layer.masksToBounds = true
        cell.myImage.layer.cornerRadius = 3.0
        cell.myImage.layer.borderWidth = 1.0
        cell.myImage.layer.borderColor = UIColor.clear.cgColor
       
        cell.myImage.layer.shadowColor = UIColor.black.cgColor
        cell.myImage.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.myImage.layer.shadowOpacity = 0.2
        cell.myImage.layer.shadowRadius = 4.0
        
        var shadowLayer = CAShapeLayer()
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4.0)
        shadowLayer.shadowRadius = 2.0
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.path = UIBezierPath(roundedRect: cell.myImage.bounds, cornerRadius: cell.myImage.layer.cornerRadius).cgPath
         cell.myImage.layer.insertSublayer(shadowLayer, at: 0)
 
    
        let containerView = UIView()
        cell.myImage.addSubview(containerView)
        
        containerView.layer.cornerRadius = 25.0
        containerView.layer.masksToBounds = true
        containerView.leadingAnchor.constraint(equalTo:  cell.myImage.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: cell.myImage.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: cell.myImage.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: cell.myImage.bottomAnchor).isActive = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
       
        
        */
        
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
        let heightPerItem = widthPerItem

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
        return sectionInsets.left
    }
}


extension VSCHomePageViewControler: UICollectionViewDelegate {
    
}
