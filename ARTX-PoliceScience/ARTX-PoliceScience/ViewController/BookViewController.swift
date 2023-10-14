//
//  BookViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class BookViewController: UIViewController {
    
    var safeAreaLength = 0
    private lazy var bookViewModel = BooksViewModel()
    
    private let navBackView: UIView = {
        let settingNavBackView = UIView()
        settingNavBackView.backgroundColor = .bgBlue
        
        return settingNavBackView
    }()
    
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
        stackView.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.1).cgColor
        stackView.layer.shadowOpacity = 1
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
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
        tv.backgroundColor = .bgGroupedPrimary
        tv.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.cellId)
        tv.sectionFooterHeight = 12
        tv.sectionHeaderHeight = 0
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.configureNavigationBar(withTitle: NavigationTitle.bookView.title)
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let window = UIApplication.shared.windows.first {
            safeAreaLength = Int(window.safeAreaInsets.top)
        }
        view.backgroundColor = .bgGroupedPrimary
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
        
        view.addSubview(navBackView)
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
        
        navBackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navBackView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            navBackView.heightAnchor.constraint(equalToConstant: navigationController!.navigationBar.frame.size.height + CGFloat(safeAreaLength))
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
        navigationController?.isNavigationBarHidden = true
    }
}
