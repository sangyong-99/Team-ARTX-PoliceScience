//
//  BookTableViewCell.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 2023/10/08.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    static let cellId = "BookTableViewCell"
    var bookIndex: Int = 0
    
    //MARK: - UI
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 1
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var bookNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.font = .subHeadBoldKR
        label.textColor = UIColor(named: "PrimaryBlack")
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.lineBreakMode = .byCharWrapping
        label.font = .caption1KR
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var purchaseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .pointBlue
        button.tintColor = .white
        button.setImage(UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.subHead)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(with item: Book, at index: Int) {
        
        bookImageView.image = item.id.bookimage
        bookNameLabel.text = item.id.bookname
        authorNameLabel.text = "\(item.authorName) 저"
        
        purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        bookIndex = index
                

        labelStackView.addArrangedSubview(bookNameLabel)
        labelStackView.addArrangedSubview(authorNameLabel)
        
       
        contentView.addSubview(bookImageView)
        contentView.addSubview(labelStackView)
        contentView.addSubview(purchaseButton)
        
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            
            bookImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            bookImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            bookImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            bookImageView.widthAnchor.constraint(equalToConstant: 58),
            bookImageView.heightAnchor.constraint(equalToConstant: 80),
            
            labelStackView.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -72),
            
            purchaseButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            purchaseButton.widthAnchor.constraint(equalToConstant: 40),
            purchaseButton.heightAnchor.constraint(equalToConstant: 40),
            purchaseButton.centerYAnchor.constraint(equalTo: labelStackView.centerYAnchor)
            
        ])
    }
}

extension BookTableViewCell {
    @objc private func purchaseButtonTapped() {
        let text = PurchaseAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.button, style: .default, handler: { _ in
            self.goToLink()
        }))
        alert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel))
        
        alert.show()
    }
    
    private func goToLink() {
        let viewModel = BooksViewModel()
        
        // 책 구매 주소
        guard let bookURL = viewModel.bookURL(at: bookIndex) else {
            return
        }

        // 에러가 났을 경우 카페로 이동
        let bookErrorURL = URL(string: "https://cafe.naver.com/khneng")!
        
        let task = URLSession.shared.dataTask(with: bookURL) { (_, response, _) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    UIApplication.shared.open(bookURL, options: [:], completionHandler: nil)
                }
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.open(bookErrorURL, options: [:], completionHandler: nil)
                }
            }
        }
        task.resume()
    }
        
}
