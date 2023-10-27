//
//  BookmarkViewController.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/12/23.
//

import UIKit

final class BookmarkViewController: UIViewController {
    
    private var bookmarkTableView = UITableView(frame: .zero, style: .insetGrouped)
    private var bookmarkViewModel = BookmarkViewModel()
    private var safeAreaLength: Double = 0
    private let navBackView: UIView = {
        let settingNavBackView = UIView()
        settingNavBackView.backgroundColor = .bgBlue
        
        return settingNavBackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let window = UIApplication.shared.windows.first {
            safeAreaLength = Double((window.windowScene?.statusBarManager?.statusBarFrame.height)!)
        }
        self.bookmarkTableView.delegate = self
        self.bookmarkTableView.dataSource = self
        self.configureTableView()
        self.configureNavigationBar()
        self.layoutBookmarkViewController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveTestNotification(_:)), name: NSNotification.Name("BackToOxview"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishTestNotification(_:)), name: NSNotification.Name("BackToOxListview"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.configureNavigationBar(withTitle: "오답 노트")
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        navigationController?.isNavigationBarHidden = false
    }
    
    
    private func configureTableView() {
        self.bookmarkTableView.separatorStyle = .singleLine
        self.bookmarkTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.bookmarkTableView.separatorInsetReference = .fromCellEdges
        self.bookmarkTableView.separatorColor = .pointGray
        
        self.bookmarkTableView.backgroundColor = .bgPrimary
        self.bookmarkTableView.delegate = self
        self.bookmarkTableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.identifier)
        self.bookmarkTableView.register(BookmarkTableViewHeader.self, forHeaderFooterViewReuseIdentifier: BookmarkTableViewHeader.identifier)
        self.bookmarkTableView.register(BookmarkEmptyTableViewCell.self, forCellReuseIdentifier: BookmarkEmptyTableViewCell.identifier)
        
        self.bookmarkTableView.sectionHeaderTopPadding = 0
        self.bookmarkTableView.sectionHeaderHeight = 89
        self.bookmarkTableView.sectionFooterHeight = 0
        self.bookmarkTableView.rowHeight = 69
        
        self.view.addSubview(self.bookmarkTableView)
        view.addSubview(navBackView)
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = NavigationTitle.bookmarkView.title
    }
    
    private func layoutBookmarkViewController() {
        bookmarkTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookmarkTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 26),
            bookmarkTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bookmarkTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            bookmarkTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        
        navBackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBackView.topAnchor.constraint(equalTo: view.topAnchor),
            navBackView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            navBackView.heightAnchor.constraint(equalToConstant: navigationController!.navigationBar.frame.size.height + Double(safeAreaLength))
        ])
    }
}


extension BookmarkViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookmarkViewModel.partCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.bookmarkViewModel.changeCurrentPart(to: section)
        
        return max(self.bookmarkViewModel.chapterCount(), 1)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BookmarkTableViewHeader.identifier) as? BookmarkTableViewHeader else { return UIView() }
        
        bookmarkViewModel.changeCurrentPart(to: section)
        header.update(bookmarkViewModel: bookmarkViewModel)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        bookmarkViewModel.changeCurrentPart(to: indexPath.section)
        bookmarkViewModel.changeCurrentChapter(to: indexPath.row)
        
        if bookmarkViewModel.chapterCount() == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkEmptyTableViewCell.identifier, for: indexPath) as? BookmarkEmptyTableViewCell else { return UITableViewCell() }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier, for: indexPath) as? BookmarkTableViewCell else { return UITableViewCell() }
        
        cell.accessoryType = .disclosureIndicator
        cell.update(bookmarkViewModel: bookmarkViewModel)
//        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookmarkViewModel.changeCurrentPart(to: indexPath.section)
        bookmarkViewModel.changeCurrentChapter(to: indexPath.row)
        
        if bookmarkViewModel.chapterCount() == 0 {
            return
        }
        
        let questions = bookmarkViewModel.chapter().questions
        
        let viewController = QuizViewController(indexPath: indexPath, showBookmarkedOnly: true, questions: questions)
        
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func didRecieveTestNotification(_ notification: Notification) {
        OperationQueue.main.addOperation { // DispatchQueue도 가능.
            self.bookmarkViewModel = BookmarkViewModel()
            self.bookmarkTableView.reloadData()
        }
    }
    
    @objc func didFinishTestNotification(_ notification: Notification) {
        OperationQueue.main.addOperation { // DispatchQueue도 가능.
            self.bookmarkViewModel = BookmarkViewModel()
            self.bookmarkTableView.reloadData()
        }
    }
}

extension BookmarkViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = true
    }
}
