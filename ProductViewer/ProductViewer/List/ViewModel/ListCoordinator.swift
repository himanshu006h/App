//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo
/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    //MARK: Properties
    var model: ListModel?
    let dispatcher = Dispatcher()
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Presenters, view controllers, view state.
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    /// use of binding for UI update
    fileprivate var viewState: ListViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])

    }
    
    func updateState() {
        var array = [ListItemViewState]()
         model?.products?.forEach({ product in
            array.append(ListItemViewState(title: product.title ?? "N/A",
                                           price: product.regularPrice?.display_string ?? "N/A",
                                           image: product.image_url,
                                           description: product.description))
            
        })
        viewState.listItems = array.map { product in
            ListItemViewState(title: product.title,
                              price: product.price,
                              image: product.image,
                              description: product.description)
        }
    }
    
    func fetchListDetails() {
        // Fetch data from the API
        NetworkDataLoader().loadResult { [weak self] result in
            switch result {
            case let .success(listInfo):
                self?.model = listInfo
                self?.updateState()
            case let .failure(error):
                DispatchQueue.main.async {
                self?.alertForError(error: error)
                }
            }
        }
    }
    
    func alertForError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        self.viewController.present(alert, animated: true, completion: nil)
    }
}

extension ListCoordinator: SelectionDelegate {
    func didSelectProduct(item: ListItemViewState) {
        let detailVC = ProductViewController(model: item)
        self.viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
