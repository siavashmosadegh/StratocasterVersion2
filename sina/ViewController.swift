//
//  ViewController.swift
//  sina
//
//  Created by Siavash Mosadegh on 5/28/20.
//  Copyright © 2020 Siavash Mosadegh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var button: UIButton!
    
    var timer : Timer?
    
    var offset: CGFloat = 200
    
    var nameOfSong : String?
    
    var numberOfPictures : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let path = Bundle.main.path(forResource: "\(nameOfSong!).mp3", ofType: nil)!
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            // couldn't find the file
        }
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        
        if timer == nil {
            button.setTitle("Pause", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(move), userInfo: nil, repeats: true)
            audioPlayer.play()
        } else {
            timer?.invalidate()
            timer = nil
            audioPlayer.pause()
            button.setTitle("Start", for: .normal)
        }
    }
    
    @objc func move () {
        if collectionView.contentOffset.x + offset >= collectionView.contentSize.width {
            timer?.invalidate()
            return
        }
        
        collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x + offset, y: collectionView.contentOffset.y), animated: true)
    }
    

}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPictures!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        guard let imageView = cell.viewWithTag(3) as? UIImageView else { return cell }
        
        imageView.image = UIImage(named: "\(nameOfSong!) "+"\(indexPath.row + 1)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let image = UIImage(named: "\(nameOfSong!) "+"\(indexPath.row + 1)") else { return .zero }
        
        return CGSize(width: image.size.width * ( image.size.height / 100 ), height: 100)
    }
}

