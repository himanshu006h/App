//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

final class ProductListView: UIView {
    // MARK: Properties
    /// Made outlets as optional to avoid crashes, SOLID principle (private IBoutlet to avoid modification form out side)
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var priceLabel: UILabel?
    @IBOutlet private weak var productImage: AsyncImageView?
    @IBOutlet private weak var containerView: UIView?
    @IBOutlet private weak var btnB2: UIButton?
}

extension ProductListView: ReusableNib {
    @nonobjc static let nibName = "ProductListView"
    @nonobjc static let reuseID = "ProductListViewIdentifier"

    @nonobjc func prepareForReuse() {
        setUpUI()
    }
    
    func configureCell(details: ListItemViewState?) {
        setUpUI()
        guard let viewDetails = details else { return }
        titleLabel?.text = viewDetails.title
        priceLabel?.text = viewDetails.price
        guard let imageLink = details?.image else { return }
        self.productImage?.loadImage(urlString: imageLink, completion: { _ in })
    }
    
    private func setUpUI() {
        btnB2?.layer.borderWidth = 0.5
        btnB2?.layer.borderColor = UIColor.lightGray.cgColor
        containerView?.layer.borderWidth = 0.5
        containerView?.layer.borderColor = UIColor.lightGray.cgColor
        containerView?.layer.shadowColor = UIColor.lightGray.cgColor
        containerView?.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView?.layer.shadowOpacity = 0.5
        containerView?.layer.shadowRadius = 1.0
    }
}
