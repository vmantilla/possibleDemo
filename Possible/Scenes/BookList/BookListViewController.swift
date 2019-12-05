//
//  BookListViewController.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

import UIKit

protocol ListBookDisplayLogic: class
{
    func displayFetchedBooks(viewModel: BookList.FetchBooks.ViewModel)
    func displayError(_ error: ServiceError?)
}

struct Constant
{
    static let tableViewReuseIdentifier = "BookTableViewCell"
}

class BookListViewController: UIViewController
{
    private var presenter: BookListPresenterProtocol
    var displayedBooks: [BookList.FetchBooks.ViewModel.DisplayedBook] = []
    @IBOutlet weak var tableView: UITableView! = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        return tv
    }()
    
    // MARK: Object Initializers
    init(presenter: BookListPresenterProtocol)
    {
        self.presenter = presenter
        super.init(nibName: String(describing: BookListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.presenter = BookListPresenter(interactor: BookListInteractor(), router: BookListRouter(navigationController: UINavigationController()))
        super.init(coder: aDecoder)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTableView()
        self.presenter.delegate = self
        fetchBooks()
    }
    
    // MARK: IN Methods
    // Fetch the list of books
    func fetchBooks()
    {
        let request = BookList.FetchBooks.Request()
        presenter.fetchBooks(request: request)
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: Constant.tableViewReuseIdentifier, bundle: nil), forCellReuseIdentifier: Constant.tableViewReuseIdentifier)
    }
}

// MARK: - ListBookDisplayLogic Delegates implementation
extension BookListViewController: ListBookDisplayLogic {
    
    func displayFetchedBooks(viewModel: BookList.FetchBooks.ViewModel) {
        self.displayedBooks = viewModel.displayedBooks
        self.tableView.reloadData()
    }
    
    func displayError(_ error: ServiceError?) {
        // TODO
    }
}

// MARK: - UICollectionViewController Delegates implementation
extension BookListViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedBook = displayedBooks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewReuseIdentifier, for: indexPath) as! BookTableViewCell
        cell.setupBook(with: displayedBook)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let displayedBook = displayedBooks[indexPath.row]
        var height: CGFloat = 0
        let title = displayedBook.title
            let font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
            let size = CGSize(width: tableView.frame.width - 100, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame =  NSString(string: title).boundingRect(
                with: size,
                options: options,
                attributes: [NSAttributedString.Key.font: font],
                context: nil)
        height = max(estimatedFrame.height + 40, 120)
        return height
    }
}
