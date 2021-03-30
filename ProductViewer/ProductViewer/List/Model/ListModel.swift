//
//  ListModel.swift
//  ProductViewer
//
//  Created by Himanshu Saraswat on 26/03/21.
//  Copyright © 2021 Target. All rights reserved.
//


import Foundation
struct ListModel : Codable {
	let products : [Products]?

	enum CodingKeys: String, CodingKey {
		case products
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		products = try values.decodeIfPresent([Products].self, forKey: .products)
	}

}
