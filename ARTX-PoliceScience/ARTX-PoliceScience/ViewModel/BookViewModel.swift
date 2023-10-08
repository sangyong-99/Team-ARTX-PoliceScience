//
//  BookViewModel.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 2023/10/08.
//

import Foundation

class BooksViewModel {
    private(set) var books: [Book] = [
        Book(id: .policeStudiesBasic, authorName: "조현"),
        Book(id: .policeStudiesPastExam, authorName: "조현")
    ]
}
