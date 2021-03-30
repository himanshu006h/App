//
//  ProductViewController.swift
//  ProductViewer
//
//  Created by Himanshu Saraswat on 27/03/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    // MARK: Properties
    private var viewModel: ProductDetailViewModel?
    @IBOutlet private weak var descriptionLabel: UILabel?
    @IBOutlet private weak var priceLabel: UILabel?
    @IBOutlet private weak var productImage: AsyncImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: Init
    init(model: ListItemViewState?) {
        super.init(nibName: nil, bundle: nil)
        viewModel = ProductDetailViewModel(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure View
    func configureView() {
        guard let details = viewModel?.model else { return }
        descriptionLabel?.text = details.description
        priceLabel?.text = details.price
        guard let imageLink = details.image else { return }
        self.productImage?.loadImage(urlString: imageLink, completion: { _ in })
    }
    
    // MARK: Button Action
    
    @IBAction func addCartBtnTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Item Added to cart!", message: "🐶", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addListBtnTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Item added to list!", message: "🐶", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        self.present(alert, animated: true, completion: nil)
    }
}
