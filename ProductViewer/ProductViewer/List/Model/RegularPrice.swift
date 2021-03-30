//
//  RegularPrice.swift
//  ProductViewer
//
//  Created by Himanshu Saraswat on 26/03/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
struct RegularPrice : Codable {
	let amount_in_cents : Int?
	let currency_symbol : String?
	let display_string : String?

	enum CodingKeys: String, CodingKey {

		case amount_in_cents = "amount_in_cents"
		case currency_symbol = "currency_symbol"
		case display_string = "display_string"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount_in_cents = try values.decodeIfPresent(Int.self, forKey: .amount_in_cents)
		currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
		display_string = try values.decodeIfPresent(String.self, forKey: .display_string)
	}

}
