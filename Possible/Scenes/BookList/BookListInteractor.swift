//
//  BookListInteractor.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

import UIKit
import RxSwift

enum BookListError: Error {
    case loadingError
}

protocol BookListInteractorProtocol
{
    var data: [Book] { get }
    
    func updateData(with data: [Book])
    func fetchBooks(request: BookList.FetchBooks.Request) -> Single<[Book]>
}

class BookListInteractor
{
    public private(set) var data: [Book] = []
    
    public init() {}
}

// MARK: BookListInteractorProtocol Methods
extension BookListInteractor: BookListInteractorProtocol
{
    // MARK: Methods
    public func updateData(with data: [Book])
    {
        self.data = data
    }
    
    func fetchBooks(request: BookList.FetchBooks.Request) -> Single<[Book]>
    {
        return Single.create { single in
            let worker = BookListWorker()
            let fetchedBooks = worker.fetchBooks(request: request)
            if !fetchedBooks.isEmpty
            {
                single(.success(fetchedBooks))
            } else {
                single(.error(BookListError.loadingError))
            }
            
            return Disposables.create()
        }
    }
}
