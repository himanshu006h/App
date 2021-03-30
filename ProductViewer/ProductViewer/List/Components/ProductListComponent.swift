//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

protocol SelectionDelegate: AnyObject {
    func didSelectProduct(item: ListItemViewState)
}

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?
    weak var delegate: SelectionDelegate?
    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.configureCell(details: item)
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        // send item for detail page
        delegate?.didSelectProduct(item: item)
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 150.0
    }
}
