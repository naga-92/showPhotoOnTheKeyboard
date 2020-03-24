//
//  selectPhotoCell.swift
//  photolibrary
//
//  Created by Nagaiwa on 2020/03/16.
//  Copyright © 2020 Nagaiwa. All rights reserved.
//

import UIKit

class selectPhotoCell: UICollectionViewCell {
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()

    var checkmarkView: UIImageView! = {
        let iv = UIImageView()
        iv.image = UIImage(named: "checkmark")!
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    var isMarked: Bool = false {
        didSet {
            if isMarked {
                self.photoImageView.addSubview(self.checkmarkView!)
            } else {
                self.checkmarkView?.removeFromSuperview()
            }
        }
    }
    
    func clearCheckmark() -> Void {
        self.isMarked = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.photoImageView.addSubview(checkmarkView)
        checkmarkView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not be implemented")
        
    }
}


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
