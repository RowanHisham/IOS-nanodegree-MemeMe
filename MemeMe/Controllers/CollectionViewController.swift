//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Rowan Hisham on 4/19/20.
//  Copyright © 2020 Rowan Hisham. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Configure CollectionView Cells Layout
    func configureUI(){
        let space:CGFloat = 2.0
        let dimensionW = (view.frame.size.width - (2 * space)) / 3.0
        let dimensionH = (view.frame.size.height - (2 * space)) / 6.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensionW, height: dimensionH)
    }
    
    // MARK: Set Number of Cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    // MARK: fill cell with image
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        cell.memeImageView?.image = memes[indexPath.row].MemeImage
        
        return cell
    }
}
