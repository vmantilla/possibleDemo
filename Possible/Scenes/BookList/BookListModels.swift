//
//  BookListModels.swift
//  Possible
//
//  Created by Raul Mantilla on 11/27/19.
//  Copyright (c) 2019 Raul Mantilla. All rights reserved.
//

enum BookList {
    // MARK: Use cases
    enum FetchBooks {
        struct Request { }
        struct Response {
            var fetchedBooks: [Book]
        }
        struct ViewModel {
            struct DisplayedBook
            {
                let title: String
                let author: String
                let imageURL: String
            }
            var displayedBooks: [DisplayedBook]
        }
    }
}

struct Book: Codable
{
    let title: String
    let author: String?
    let imageURL: String?
}
