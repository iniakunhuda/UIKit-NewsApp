//
//  NewsResponse.swift
//  UIKitNewsApp
//
//  Created by Miftahul Huda on 08/02/23.
//

import Foundation

protocol ApiResponse: Codable {}

struct BaseResponse<T: ApiResponse>: Codable {
    let status: String
    let totalResults: Int
    let articles: [T]
}


struct SourceResponse: Codable {
    let id: String? = nil
    let name: String?
}

struct NewsResponse: ApiResponse {
    let source: SourceResponse
    let author: String?
    let title, description: String?
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String?
}

extension NewsResponse {
    func toNews() -> News {
        return News(
            source: Source(id: self.source.id, name: self.source.name ?? ""),
            author: self.author ?? "",
            title: self.title ?? "",
            description: self.description ?? "",
            url: self.url,
            urlToImage: self.urlToImage,
            publishedAt: self.publishedAt,
            content: self.content ?? ""
        )
    }
}
