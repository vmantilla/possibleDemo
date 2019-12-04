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
        //imageView.image = nil
    }
    
    func setupBook(with book: BookList.FetchBooks.ViewModel.DisplayedBook) {
        self.title.text = book.title
        //self.autor.text = book.author
    }
    
    private func showData(viewModel: BookList.FetchBooks.ViewModel.DisplayedBook) {
        //let placeholderImage = UIImage(named: "defaultMovie")!
//        let posterUrl = ImagePath.poster_path_original.rawValue + viewModel.poster_path
//
//        guard let url = URL(string: posterUrl) else {
//            poster.image = placeholderImage
//            return
//        }
//
//        let imageFilter = AspectScaledToFillSizeFilter(size: poster.frame.size)
//
//        poster.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: imageFilter, progress: nil, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: { (image) in
//        })
    }
}
