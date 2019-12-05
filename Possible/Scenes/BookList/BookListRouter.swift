//
//  BookListRouter.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

import UIKit

enum BookListTransition {
    case goToNextPage
    case goBack
}

protocol BookListRouterProtocol
{
    func performTransition(transition: BookListTransition)
}

class BookListRouter: NSObject, BookListRouterProtocol
{
    private var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?)
    {
        self.navigationController = navigationController
    }
    
    func performTransition(transition: BookListTransition)
    {
        switch transition {
        case .goToNextPage:
            goToNextPage()
        case .goBack:
            goBack()
        }
    }
}

// MARK: Routing Methods
extension BookListRouter
{
    func goToNextPage()
    {
        // TO DO
    }
    
    func goBack()
    {
        navigationController?.popViewController(animated: true)
    }
}
