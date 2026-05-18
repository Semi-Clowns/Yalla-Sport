//
//  NewsResponse.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 18/05/2026.
//

import Foundation

/**
 "status": "ok",
 "totalResults": 52,
 -"articles":*/
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url
        case urlToImage
        case publishedAt
        case content
    }
}
struct Source: Codable {
    let id: String?
    let name: String
}
