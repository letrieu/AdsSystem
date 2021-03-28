//
//  HomeViewController.swift
//  ios-app
//
//  Created by TrieuLD on 27/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit
import MultiPlatformLibrary
import MultiPlatformLibraryMvvm
import MultiPlatformLibraryUnits

struct HomeUX {
    static var numberOfItemsPerRow: CGFloat {
        get {
            if (UICommonValue.isIpad) {
                if (UICommonValue.isLandscape) {
                    return 4
                }
                return 3
            } else {
                if (UICommonValue.isLandscape) {
                    return 3
                }
                return 2
            }
            
        }
    }
}

class HomeViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    private var viewModel: ListViewModel<PostCate>!
    private var dataSource: CollectionUnitsSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        self.title = "Home"
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.register(PostCateCell.self, forCellWithReuseIdentifier: PostCateCell.reusableIdentifier())
        collectionView.backgroundColor = .clear
        collectionView.isSkeletonable = true
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        
        self.setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = AppComponent.factory.postFactory.createListViewModel()
        dataSource = CollectionUnitsSourceKt.default(for: collectionView)
        
        // manual bind to livedata, see https://github.com/icerockdev/moko-mvvm
        viewModel.state.data().addObserver { [weak self] itemsObject in
            guard let items = itemsObject as? [CollectionUnitItem] else { return }
            
            self?.dataSource.unitItems = items
            self?.collectionView.reloadData()
        }
        
//        errorView.bindVisibility(liveData: viewModel.state.isErrorState())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = self.view.bounds
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = UICommonValue.screenWidth/HomeUX.numberOfItemsPerRow
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
