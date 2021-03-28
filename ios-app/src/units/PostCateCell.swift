//
//  PostCateCell.swift
//  ios-app
//
//  Created by TrieuLD on 27/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit
import Nuke
import SkeletonView
import MultiPlatformLibraryUnits

class PostCateCell: UICollectionViewCell, Fillable {
    typealias DataType = CellModel
    
    struct CellModel {
        let id: Int64
        let title: String
        let iconUrl: String
    }
    
    
    var containerView: UIView!
    var blurView: UIView!
    var iconView: UIImageView!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isSkeletonable = true
        
        containerView = UIView()
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = .gray
        containerView.isSkeletonable = true
        self.contentView.addSubview(containerView)
        
        iconView = UIImageView()
        iconView.layer.cornerRadius = 4
        iconView.clipsToBounds = true
        iconView.contentMode = .scaleAspectFill
        iconView.isHiddenWhenSkeletonIsActive = true
        containerView.addSubview(iconView)
        
        blurView = UIView()
        blurView.backgroundColor = .black
        blurView.alpha = 0.3
        blurView.layer.cornerRadius = 4
        blurView.isHiddenWhenSkeletonIsActive = true
        containerView.addSubview(blurView)
        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.isHiddenWhenSkeletonIsActive = true
        containerView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.frame = self.contentView.bounds.inset(by: UIEdgeInsets(inset: 8))
        containerView.layer.applySketchShadow()
        
        iconView.frame = containerView.bounds
        blurView.frame = containerView.bounds
        titleLabel.frame = containerView.bounds.inset(by: UIEdgeInsets(inset: 8))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(_ data: PostCateCell.CellModel) {
        titleLabel.text = data.title
        if let imageUrl =  URL(string: data.iconUrl) {
            Nuke.loadImage(with: imageUrl, into: iconView)
        }
        containerView.backgroundColor = UIColor.randomColorWithString(data.title)
    }
    
    func update(_ data: PostCateCell.CellModel) {
        
    }
}

extension PostCateCell: Reusable {
    static func reusableIdentifier() -> String {
        return "PostCateCell"
    }
}
