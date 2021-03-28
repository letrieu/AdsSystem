//
//  TLCollectionViewCellUnit.swift
//  ios-app
//
//  Created by TrieuLD on 27/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit
import MultiPlatformLibrary
import MultiPlatformLibraryUnits

open class TLCollectionViewCellUnit<Cell: Reusable & Fillable & UICollectionViewCell> : UICellUnit<Cell>, CollectionUnitItem {
    
    public var reusableIdentifier: String {
        get {
            return reuseId
        }
    }
    
    public func register(intoView: Any?) {
        guard let collectionView = intoView as? UICollectionView else { return }
        collectionView.registerReusableCell(Cell.self)
    }
    
    public func bind(collectionViewCell: UICollectionViewCell) {
        guard let cell = collectionViewCell as? Cell else { return }
        configurator?(cell)
        cell.fill(data)
    }
}
