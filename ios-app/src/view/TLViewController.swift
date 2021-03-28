//
//  TLViewController.swift
//  ios-app
//
//  Created by TrieuLD on 28/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit
import HGPlaceholders
import MultiPlatformLibrary
import MultiPlatformLibraryMvvm

class TLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateNavigationColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.updateNavigationColor()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return ThemeManager.instance.statusBarStyle
    }
    
    func updateNavigationColor() {
        let startColor = UIColor(hex: 0x1d976c)
        let endColor = UIColor(hex: 0x65d39b)
        
        let bgImage = self.imageWithGradient(startColor: startColor, endColor: endColor, size: CGSize(width: UICommonValue.screenWidth, height: 1))
        
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(patternImage: bgImage)
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: bgImage)
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(bgImage, for: UIBarMetrics.default)
        }
    }
    
    func imageWithGradient(startColor:UIColor, endColor:UIColor, size:CGSize, horizontally:Bool = true) -> UIImage {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        if horizontally {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

//Place holder

extension TLViewController {
    func observerPlaceHolder<T>(for collectionView: CollectionView, with viewModel: ListViewModel<T>) {
        viewModel.state.isEmptyState().addObserver { [weak collectionView] isEmpty in
            if let empty = isEmpty {
                if (empty.boolValue) {
                    collectionView?.showNoResultsPlaceholder()
                }
            }
        }
        viewModel.state.isLoadingState().addObserver { [weak collectionView] isLoading in
            if let loading = isLoading {
                if (loading.boolValue) {
                    collectionView?.showLoadingPlaceholder()
                }
            }
        }
        
        viewModel.state.isErrorState().addObserver { [weak collectionView] isError in
            if let error = isError {
                if (error.boolValue) {
                    collectionView?.showErrorPlaceholder()
                }
            }
        }
    }
}
