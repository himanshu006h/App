//
//  ListViewController.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

class ListViewController: UIViewController {
    
    // MARK: Properties
    var viewModel: ListCoordinator?
    fileprivate var coordinator: ListCoordinator!

    // MARK: View Initialize
    class func viewControllerFor(coordinator: TempoCoordinator) -> ListViewController {
        let viewController = ListViewController()
        viewController.coordinator = coordinator as? ListCoordinator
        
        return viewController
    }
    
    // MARK: Set up CollectionView
    lazy var collectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .narrow, left: .none)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .narrow, right: .none, bottom: .none, left: .none)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: harmonyLayout)
        collectionView.backgroundColor = .targetFadeAwayGrayColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    // MARK: ViewDid load
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchDetails()
    }
    
    func setUpUI() {
        view.addAndPinSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        var component = ProductListComponent()
        component.delegate = self.coordinator
        let components: [ComponentType] = [
            component
        ]
        
        let componentProvider = ComponentProvider(components: components, dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView, componentProvider: componentProvider)
        
        coordinator.presenters = [
            SectionPresenter(adapter: collectionViewAdapter),
        ]

    }
    // MARK: Fetch product list
    func fetchDetails() {
        self.coordinator.fetchListDetails()
    }
}


