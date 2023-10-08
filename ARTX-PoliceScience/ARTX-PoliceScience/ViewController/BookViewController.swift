//
//  BookViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class BookViewController: UIViewController {
    
    private lazy var bookViewModel = BooksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    private func setup() {
        
        self.navigationController?.navigationBar.topItem?.title = "조현 경찰학이란?"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        tableView.dataSource = self
        tableView.delegate = self
        
        mainStackView.addArrangedSubview(mainImageView)
        mainStackView.addArrangedSubview(introLabelStack)
        
        introLabelStack.addArrangedSubview(introTitleLabel)
        introLabelStack.addArrangedSubview(introSubLabel)
    
        allMainStackView.addArrangedSubview(mainStackView)
        allMainStackView.addArrangedSubview(tableView)
        
        view.addSubview(allMainStackView)
        
    }
    
    private func layout() {
        allMainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allMainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            allMainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            allMainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            allMainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    let allMainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    let mainStackView: UIStackView = {
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
        label.textColor = .black
        label.text = "헤드라인 헤드라인 헤드라인 헤드라인 헤드라인"
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let introSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
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
        cell.configure(with: book)
        cell.layer.cornerRadius = 14
        
        return cell
    }
    
}
