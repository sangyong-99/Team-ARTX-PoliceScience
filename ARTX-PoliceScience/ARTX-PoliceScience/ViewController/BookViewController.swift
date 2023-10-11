//
//  BookViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class BookViewController: UIViewController {
    
    private lazy var bookViewModel = BooksViewModel()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 0
        
        return stackView
    }()
    
    let mainImageView: UIImageView = {
        let image = UIImage(named: "Thumbnail")
        let imageView = UIImageView(image: image)
        imageView.heightAnchor.constraint(equalToConstant: 308).isActive = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let introLabelStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.spacing = 20
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    let introTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(named: "PrimaryBlack")
        label.text = "헤드라인 헤드라인 헤드라인 헤드라인 헤드라인"
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let introSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(named: "PrimaryBlack")
        label.text = "상세 설명 상세 설명 상세 설명 상세 설명 상세 설명 상세 설명 상세 설명 상세 설명 상세 설명 상세 설명"
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tv =  UITableView(frame: .zero, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.cellId)
        tv.sectionFooterHeight = 12
        tv.sectionHeaderHeight = 0
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.configureNavigationBar(withTitle: NavigationTitle.bookView.title)
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        setup()
        layout()
    }
    
    private func setup() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        labelStackView.addArrangedSubview(mainImageView)
        labelStackView.addArrangedSubview(introLabelStack)
        
        introLabelStack.addArrangedSubview(introTitleLabel)
        introLabelStack.addArrangedSubview(introSubLabel)
    
        mainStackView.addArrangedSubview(labelStackView)
        mainStackView.addArrangedSubview(tableView)
        
        view.addSubview(mainStackView)
        
    }
    
    private func layout() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension BookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookViewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = bookViewModel.books[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.cellId, for: indexPath) as! BookTableViewCell
        cell.selectionStyle = .none
        cell.setup(with: book, at: indexPath.section)
        cell.layer.cornerRadius = 14
        
        return cell
    }
    
}

extension BookViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
