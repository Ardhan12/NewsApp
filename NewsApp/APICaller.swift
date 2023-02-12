//
//  APICaller.swift
//  NewsApp
//
//  Created by Arief Ramadhan on 08/02/23.
//

import Foundation
final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topheadlineURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=dcdfbc0947224b5da75e07cf3177e76e")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topheadlineURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    
                    print("Article: \(result.articles.count)")
                    for article in result.articles {
                        print(article.title)
                    }
                    
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


//models
// MARK: - News
struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}


