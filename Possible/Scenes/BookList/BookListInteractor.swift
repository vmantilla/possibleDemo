//
//  BookListInteractor.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

import UIKit

enum BookListResponse {
    case success(response: BookList.FetchBooks.Response)
    case failure(error: ServiceError?)
}

protocol BookListInteractorProtocol {
    var data: [Book] { get }
    var delegate: BookListPresenterProtocol? { get set }
    func fetchBooks(request: BookList.FetchBooks.Request)
    
    // This method is not used, but it represent how data is update on the interactor from outside
    func updateData(with data: [Book])
}

class BookListInteractor {
    public private(set) var data: [Book] = []
    
    weak var delegate: BookListPresenterProtocol?
    var booksDataProvider: ServiceDataProvider
    
    init() {
        self.booksDataProvider = ServiceDataProvider()
    }
}

// MARK: BookListInteractorProtocol Methods
extension BookListInteractor: BookListInteractorProtocol {
    
    // This method is not used, but it represent how data is saved on the interactor.
    public func updateData(with data: [Book]) {
        self.data = data
    }
    
    func fetchBooks(request: BookList.FetchBooks.Request) {
        booksDataProvider.fetchBooks(request: request) { (books, error) in
            if error != nil {
               self.delegate?.presentResponse(response: .failure(error: error))
            } else {
                // This method is not used, but it represent how data is saved on the interactor.
                self.updateData(with: books)
                
                let response = BookList.FetchBooks.Response(fetchedBooks: books)
                self.delegate?.presentResponse(response: .success(response: response))
            }
        }
    }
}
