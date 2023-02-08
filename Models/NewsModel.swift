//
//  NewsModel.swift
//  UIKitNewsApp
//
//  Created by Miftahul Huda on 08/02/23.
//

import Foundation


struct Source: Codable {
    let id: String?
    let name: String
}

struct News: Codable{
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String?
    
    init(
        source: Source,
        author: String?,
        title: String,
        description: String,
        url: String,
        urlToImage: String,
        publishedAt: String,
        content: String?
    ) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
