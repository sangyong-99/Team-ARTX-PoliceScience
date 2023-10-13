//
//  BookmarkViewController.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/12/23.
//

import UIKit

final class BookmarkViewController: UIViewController {
    
    private var bookmarkTableView = UITableView()
    private var bookmarkViewModel = BookmarkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookmarkTableView.delegate = self
        self.bookmarkTableView.dataSource = self
        self.configureTableView()
        self.configureNavigationBar()
        self.layoutBookmarkViewController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    
    private func setupData() {
        
    }
    
    private func configureTableView() {
        self.bookmarkTableView.separatorStyle = .singleLine
        self.bookmarkTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.bookmarkTableView.separatorInsetReference = .fromCellEdges
        self.bookmarkTableView.separatorColor = .lineGray
        
        self.bookmarkTableView.backgroundColor = .bgGroupedPrimary
        self.bookmarkTableView.delegate = self
        self.bookmarkTableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.identifier)
        self.bookmarkTableView.register(BookmarkTableViewHeader.self, forHeaderFooterViewReuseIdentifier: BookmarkTableViewHeader.identifier)
        
        self.view.addSubview(self.bookmarkTableView)
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = NavigationTitle.bookmarkView.title

    }
    
    private func layoutBookmarkViewController() {
        bookmarkTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookmarkTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 26),
            bookmarkTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bookmarkTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            bookmarkTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}


extension BookmarkViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookmarkViewModel.getPartCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookmarkViewModel.getChapterCount()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BookmarkTableViewHeader.identifier) as? BookmarkTableViewHeader else { return UIView() }
        
        header.update(bookmarkViewModel: bookmarkViewModel)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier, for: indexPath) as? BookmarkTableViewCell else { return UITableViewCell() }
        
        cell.accessoryType = .disclosureIndicator
        cell.update(bookmarkViewModel: bookmarkViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = QuizViewController()
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
