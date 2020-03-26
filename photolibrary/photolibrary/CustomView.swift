//
//  CustomView.swift
//  photolibrary
//
//  Created by Nagaiwa on 2020/03/19.
//  Copyright © 2020 Nagaiwa. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "selectPhotoCell"

class CustomView: UIView,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [UIImage]()
    var assets = [PHAsset]()
    var selectedImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //cell登録
        collectionView.register(selectPhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchPhotos()
        
        self.collectionView.allowsMultipleSelection = true
    }
}

extension CustomView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
     // - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! selectPhotoCell
        
        cell.photoImageView.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell: selectPhotoCell = collectionView.cellForItem(at: indexPath) as? selectPhotoCell else { return }
        if self.collectionView.allowsMultipleSelection {
            cell.isMarked = true
            print("タップしたね？")
        }

        self.selectedImage = images[indexPath.row]
//        self.collectionView?.reloadData()
        
        //タップすると上に戻る
//        let indexPath = IndexPath(item: 0, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell: selectPhotoCell = collectionView.cellForItem(at: indexPath) as? selectPhotoCell else { return }
        if self.collectionView.allowsMultipleSelection {
            cell.isMarked = false
             print("タップキャンセルだね？")
        }
    }
    
    func getAssetFetchOptions() -> PHFetchOptions {
        let options = PHFetchOptions()
        
        // fetch limit
        options.fetchLimit = 100
        
        // sort photos by date
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        
        // set sort descriptor for options
        options.sortDescriptors = [sortDescriptor]
        
        // return options
        return options
    }
    
    func fetchPhotos() {
        let allPhotos = PHAsset.fetchAssets(with: .image, options: getAssetFetchOptions())
        
        // fetch images on background thread
        DispatchQueue.global(qos: .background).async {
            
            // enumerate objects
            allPhotos.enumerateObjects({ (asset, count, stop) in
                
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                // request image representation for specified asset
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let image = image {
                        
                        // append image to data source
                        self.images.append(image)
                        
                        // append asset to data source
                        self.assets.append(asset)
                        
                        // set selected image with first image
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                        
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                        
                        // reload collection view with images once count has completed
                        //ここに入ってたDispatchQueueを外すことで早くなった
//                        if count == allPhotos.count - 1 {
//
//                            // reload collection view on main thread
//
//                        }
                    }
                })
            })
        }
    }
}
