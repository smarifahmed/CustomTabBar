//
//  PurpleVC.swift
//  RnD - Personal
//
//  Created by SM Arif Ahmed on 4/2/22.
//

import UIKit

class PurpleVC: UIViewController {
    
    private let showTabbarButton : UIButton = {
        let button = UIButton()
        button.setTitle("Show TabBar", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let hideTabbarButton : UIButton = {
        let button = UIButton()
        button.setTitle("Hide TabBar", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 15
        [showTabbarButton,
         hideTabbarButton].forEach { button in
            stack.addArrangedSubview(button)
        }
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        print("🟣 Purple VC")
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        showTabbarButton.addTarget(self, action: #selector(showTabBarAction), for: .touchUpInside)
        hideTabbarButton.addTarget(self, action: #selector(hideTabBarAction), for: .touchUpInside)
    }
    
    @objc func showTabBarAction(){
        TAB_BAR.showTabbar()
    }

    @objc func hideTabBarAction(){
        TAB_BAR.hideTabbar()
    }
}
