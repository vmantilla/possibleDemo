//
//  BookListPresenter.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

import UIKit
import RxSwift

enum BookListString: String {
    case loadingError = "Ocurrio un error cargando los datos"
}

public enum BookListPresenterAction {
    case showData
    case showError(_ error: String)
}

protocol BookListPresenterProtocol
{
    var onAction: Observable<BookListPresenterAction> { get }
    func handleAction(_ action: BookListAction)
    func fetchBooks(request: BookList.FetchBooks.Request)
}

class BookListPresenter: BookListPresenterProtocol
{
    private let interactor: BookListInteractorProtocol
    private let router: BookListRouterProtocol
    private let disposeBag = DisposeBag()
    private let onActionSubject = PublishSubject<BookListPresenterAction>()
    
    public init(interactor: BookListInteractorProtocol, router: BookListRouterProtocol)
    {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: BookListPresenterProtocol IN Methods
extension BookListPresenter
{
    var onAction: Observable<BookListPresenterAction> {
        return onActionSubject.asObservable()
    }
    
    public func fetchBooks(request: BookList.FetchBooks.Request) {
        interactor
            .fetchBooks(request: request)
            .asObservable()
            .subscribe(
                onNext: { [weak self] fetchedBooks in
                    let displayedBooks = fetchedBooks.map {
                        return Book(id: $0.id, description: $0.description)
                    }
                    self?.interactor.updateData(with: displayedBooks)
                    self?.onActionSubject.onNext(.showData)
                    
                }, onError: { [weak self] error in
                    switch error as! BookListError {
                    case .loadingError:
                        self?.onActionSubject.onNext(.showError(BookListString.loadingError.rawValue))
                    }
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: BookListPresenter OUT Methods
extension BookListPresenter
{
    var data: [Book]
    {
        return interactor.data
    }
    
    func handleAction(_ action: BookListAction)
    {
        switch action {
        case .goToDetails:
            print("handleTransition(transition: .goToDetails())")
        case .showMessage:
            print("show message")
        }
    }
    
    public func handleTransition(transition: BookListTransition) {
        router.performTransition(transition: transition)
    }
}
