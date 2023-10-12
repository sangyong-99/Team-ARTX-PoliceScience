//
//  QuizViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class QuizViewController: UIViewController {
    
    private let titleView = TitleView()
    private let progressView = ProgressView()
    private let quizView = QuizView()
    private let oxbuttonView = OXbuttonView()
    
//    private lazy var vStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [
//            titleView,
//            progressView,
//            quizView,
//            oxbuttonView,
////            UIView()
//        ])
//        stackView.axis = .vertical
//        stackView.spacing = 36
//        stackView.distribution = .fill
//
//        return stackView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.configureNavigationBar(withTitle: "01 경찰학의 기초이론")
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        
        layout()
    }
    
    private func layout() {
        view.addSubview(titleView)
        view.addSubview(progressView)
        view.addSubview(quizView)
        view.addSubview(oxbuttonView)
        
        titleView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 45)
        progressView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 28)
        quizView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 390)
        oxbuttonView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 130)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension QuizViewController {
    @objc func backButtonTapped() {
        
    }
}
