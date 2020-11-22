//
//  UnsplashRepository.swift
//  Unsplash_clone
//
//  Created by jsshin on 2020/11/19.
//  Copyright © 2020 jaycesub. All rights reserved.
//

import Foundation

class UnsplashRepository: PhotosRepository {
    
    enum HttpMethod: String {
        case get
        case post
        case put
        case delete
    }
    
    private let baseUrl = "https://api.unsplash.com"
    private let accessKey = "htWxW5WOxaTNO4zXtc46YsDXIaIwDSXidtSUGtzmF7Q"
    
    lazy var httpHeader:[String: String] = {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID \(accessKey)"
        return headers
    }()
    
    func fetchPhotos(page: Int, completion: @escaping ([PhotoModel]) -> Void) {
        var urlComponents = URLComponents(string: "\(baseUrl)/photos")
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: String(describing: page))
        ]
        if let url = urlComponents?.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = httpHeader
            urlRequest.httpMethod = HttpMethod.get.rawValue
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    do {
                        let images = try JSONDecoder().decode([PhotoDTO].self, from: data).map { $0.toDomain() }
                        completion(images)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func searchPhotos(query: String, page: Int, completion: @escaping ([PhotoModel]) -> Void) {
        var urlComponents = URLComponents(string: "\(baseUrl)/search/photos")
        urlComponents?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(describing: page))
        ]
        if let url = urlComponents?.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = httpHeader
            urlRequest.httpMethod = HttpMethod.get.rawValue
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    do {
                        let images = try JSONDecoder().decode(SearchPhotosResponseDTO.self, from: data).toDomain()
                        completion(images)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
}
