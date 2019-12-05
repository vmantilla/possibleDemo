//
//  DataProvider.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright © 2019 Raul Mantilla. All rights reserved.
//

import Foundation

enum ServiceError: Error
{
    case notConnectivity
    case serviceError(String)
    case unknown
}

struct Contants
{
    static let home_path = "http://de-coding-test.s3.amazonaws.com"
}

enum BooksPath: String
{
    case books = "/books.json"
}

final class ServiceDataProvider
{
    var dataTask: URLSessionDataTask?
    
    init() { }
    
    func fetchBooks(request: BookList.FetchBooks.Request, completionHandler completion: @escaping ([Book], ServiceError?) -> Void) {
        
        // request is not used, it's there just to clarify how params are handled
        
        let urlString = Contants.home_path + BooksPath.books.rawValue
        
        // I Could used alamofire here,
        //but I'm using URLSession according to the requirements

        let defaultSession = URLSession(configuration: .default)
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: urlString) {
            guard let url = urlComponents.url else {
                return
            }
            dataTask =
                defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if error != nil {
                        completion([], .unknown)
                    } else if
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        do {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            let books = try decoder.decode([Book].self, from: data)
                            DispatchQueue.main.async {
                                completion(books, nil)
                            }
                        } catch {
                            completion([], .unknown)
                        }
                    } else {
                         completion([], .unknown)
                    }
            }
            dataTask?.resume()
        }
    }
}
