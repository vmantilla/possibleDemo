//
//  BookTableViewCell.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
    }
    
    func setupBook(with book: BookList.FetchBooks.ViewModel.DisplayedBook) {
        self.title.text = book.title
        self.autor.text = book.author
        guard let url = URL(string: book.imageURL) else {
            return
        }
        downloadImage(from: url)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self?.poster.image = UIImage(data: data)
            }
        }
    }
}
