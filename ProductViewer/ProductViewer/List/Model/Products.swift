//
//  Products.swift
//  ProductViewer
//
//  Created by Himanshu Saraswat on 26/03/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
struct Products : Codable {
	let id : Int?
	let title : String?
	let aisle : String?
	let description : String?
	let image_url : String?
	let regularPrice : RegularPrice?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case aisle = "aisle"
		case description = "description"
		case image_url = "image_url"
		case regularPrice = "regular_price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		aisle = try values.decodeIfPresent(String.self, forKey: .aisle)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        regularPrice = try values.decodeIfPresent(RegularPrice.self, forKey: .regularPrice)
	}

}
