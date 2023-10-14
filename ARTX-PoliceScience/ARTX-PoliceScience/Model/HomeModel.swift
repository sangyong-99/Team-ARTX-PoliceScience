//
//  HomeModel.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/9/23.
//

import UIKit

struct HomeTableSection {
    let partNumber: String
    let partTitle: String
    let chapters: [HomeTableCell]
}

struct HomeTableCell {
    var completionIcon: UIImage
    let chapterNumber: String
    let chapterTitle: String
    let quizCount: String
}
