//
//  PostCateListUnitsFactory.swift
//  ios-app
//
//  Created by TrieuLD on 27/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import Foundation
import MultiPlatformLibrary
import MultiPlatformLibraryUnits

class PostCateListUnitsFactory: SharedFactoryPostCategoryUnitsFactory {
    func createCateTile(
        id: Int64,
        title: String,
        iconUrl: String) -> CollectionUnitItem {
        return TLCollectionViewCellUnit<PostCateCell>(
            data: PostCateCell.CellModel(
                id: id,
                title: title,
                iconUrl: iconUrl
            ),
            itemId: id,
            configurator: nil
        )
    }
}
