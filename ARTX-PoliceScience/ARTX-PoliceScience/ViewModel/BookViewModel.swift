//
//  BookViewModel.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 2023/10/08.
//

import Foundation

class BooksViewModel {
    private(set) var books: [Book] = [
        Book(id: .policeStudiesBasic, authorName: "조현", bookUrl: "https://www.aladin.co.kr/shop/wproduct.aspx?ItemId=315827310"),
        Book(id: .policeStudiesPastExam, authorName: "조현", bookUrl: "https://www.aladin.co.kr/shop/wproduct.aspx?ItemId=315579658")
    ]
        
    // 책의 URL을 반환하는 메서드
    func bookURL(at index: Int) -> URL? {
        guard index >= 0, index < books.count else {
            return nil
        }
        return URL(string: books[index].bookUrl)
    }
}
