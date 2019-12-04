//
//  BookListViewController.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController
{
    private var presenter: BookListPresenterProtocol
    
    // MARK: Object Initializers
    init(presenter: BookListPresenterProtocol)
    {
        self.presenter = presenter
        super.init(nibName: String(describing: BookListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.presenter = BookListPresenter(interactor: BookListInteractor(), router: BookListRouter(navigationController: self.navigationController))
        super.init(coder: aDecoder)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchBooks()
    }
    
    // MARK: IN Methods
    // Fetch the list of books
    func fetchBooks()
    {
        let request = BookList.FetchBooks.Request()
        presenter.fetchBooks(request: request)
    }
    
    func showData() {
        
    }
    
    func showError(error: String) {
        
    }
}

// MARK: - UICollectionViewController Delegates implementation

extension BookListViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    struct Constant
    {
        static let collectionItemReuseIdentifier = "MovieCollectionViewItem"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayedMovie = displayedMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.collectionItemReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.setup(withViewModel: displayedMovie)
        return cell
    }
}
extension BookListViewController
{
    @IBAction func didSelectButton(sender: UIButton?)
    {
        self.handleAction(.button1Selected)
    }
    
    func handleAction(_ action: BookListViewControllerAction)
    {
        switch action
        {
        case .button1Selected:
            print("Selected Button 1")
            presenter.handleAction(.goToDetails)
        case .button2Selected:
            print("Selected Button 2")
            presenter.handleAction(.showMessage)
        }
    }
}
