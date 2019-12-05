d .//
//  BookListPresenter.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

import UIKit

struct Default
{
    static let imageURL = "https://edgeplay.files.wordpress.com/2011/05/classic_red_book_cover_by_semireal_stock.jpg"
    static let author = "Anonymous"
}

public enum BookListPresenterAction {
    case showData
    case showError(_ error: String)
}

protocol BookListPresenterProtocol: class
{
    func fetchBooks(request: BookList.FetchBooks.Request)
    func presentResponse(response: BookListResponse)
    var delegate: ListBookDisplayLogic? { get set }
}

class BookListPresenter
{
    private var interactor: BookListInteractorProtocol
    private let router: BookListRouterProtocol
    
    weak var delegate: ListBookDisplayLogic?
    
    public init(interactor: BookListInteractorProtocol, router: BookListRouterProtocol)
    {
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
}

// MARK: BookListPresenterProtocol
extension BookListPresenter: BookListPresenterProtocol
{
    public func fetchBooks(request: BookList.FetchBooks.Request) {
        interactor.fetchBooks(request: request)
    }
    
    func presentResponse(response: BookListResponse) {
        switch response {
        case .success(let response):
            let booksToDisplay = response.fetchedBooks.map { book -> BookList.FetchBooks.ViewModel.DisplayedBook  in
                let booktoDiplay = BookList.FetchBooks.ViewModel.DisplayedBook(
                    title: book.title,
                    author: book.author ?? Default.author,
                    imageURL: book.imageURL ?? Default.imageURL
                )
                return booktoDiplay
            }
            self.delegate?.displayFetchedBooks(viewModel:  BookList.FetchBooks.ViewModel(displayedBooks: booksToDisplay))
        case .failure(let error):
            self.delegate?.displayError(error)
        }
    }
}
