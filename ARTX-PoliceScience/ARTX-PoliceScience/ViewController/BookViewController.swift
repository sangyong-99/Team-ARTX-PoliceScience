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
        settingNavBackView.backgroundColor = .pointBg
        
        return settingNavBackView
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
        label.font = .subHeadBoldKR
        label.textColor = UIColor(named: "PrimaryBlack")
        label.text = "iOS 글로벌 개발자로의 성장을 꿈꾸는 당신"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let introSubLabel: UILabel = {
        let label = UILabel()
        label.font = .subHeadKR
        label.textColor = UIColor(named: "PrimaryBlack")
        label.text = "애플 아카데미를 통해 여러분은 한 분야에 깊이 있는\n지식은 물론 관련 분야에 폭넓은 지식을 두루 갖춘\n“T형 인재”로 거듭날 것입니다."
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = .artxLogo
        image.heightAnchor.constraint(equalToConstant: 308).isActive = true
        image.contentMode = .scaleAspectFit
        return image
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
        view.backgroundColor = .bgPrimary
        setup()
        layout()
    }
    
    private func setup() {
        
        labelStackView.addArrangedSubview(mainImageView)
        labelStackView.addArrangedSubview(introLabelStack)
        
        introLabelStack.addArrangedSubview(introTitleLabel)
        introLabelStack.addArrangedSubview(introSubLabel)
    
        view.addSubview(navBackView)
        view.addSubview(labelStackView)
        view.addSubview(logoImageView)
        
    }
    
    private func layout() {
        
        navBackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navBackView.topAnchor.constraint(equalTo: view.topAnchor),
            navBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBackView.heightAnchor.constraint(equalToConstant: navigationController!.navigationBar.frame.size.height + CGFloat(safeAreaLength)),

            labelStackView.topAnchor.constraint(equalTo: navBackView.bottomAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            logoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 70),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}

extension BookViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = true
    }
}
