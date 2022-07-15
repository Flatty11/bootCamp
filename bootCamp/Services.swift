//
//  Services.swift
//  bootCamp
//
//  Created by Илья on 7/15/22.
//

import Foundation

struct Root: Codable {
    let body: middleItem
}

struct middleItem: Codable {
    let services: [InnerItem]
}

struct InnerItem: Codable {
    let name: String
    let description: String
    let link: URL
    let icon_url: URL
}
