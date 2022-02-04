//
//  TabBarController.swift
//  RnD - Personal
//
//  Created by SM Arif Ahmed on 4/2/22.
//

import UIKit

class TabBarController: UIViewController {
    
    static let viewControllers : [UIViewController] = [GreenVC(),
                                                       RedVC(),
                                                       YellowVC(),
                                                       PurpleVC()]
    
    private var oldIndex : Int?
    private var tabBarTopAnchor : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🧩 TabBar Controller Loaded")
        prepareTabVarView()
        switchTab(0)
    }
    
    private func prepareTabVarView(){
        let tabBarView = TabBarView()
        view.addSubview(tabBarView)
        
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabBarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tabBarTopAnchor = tabBarView.topAnchor.constraint(equalTo: view.bottomAnchor,constant:
                                                            -TabBarView.selfHeight)
        tabBarTopAnchor.isActive = true
        tabBarView.heightAnchor.constraint(equalToConstant: TabBarView.selfHeight).isActive = true
        
        tabBarView.tappedIndex = {[weak self] (index) in
            print("☘️ Tapped Index :",index)
            self!.switchTab(index)
        }
    }
    
    private func switchTab(_ index : Int){
        guard index != oldIndex else { return }
        
        add(TabBarController.viewControllers[index])
        
        if let oldIndex = oldIndex {
            remove(TabBarController.viewControllers[oldIndex])
        }
        
        oldIndex = index
    }
}

// MARK: - View Containment API
extension TabBarController {

  func add(_ child: UIViewController, frame: CGRect? = nil) {
    // 1.
    addChild(child)

    // 2.
    if let frame = frame {
      child.view.frame = frame
    }

    // 3.
    view.addSubview(child.view)
    view.sendSubviewToBack(child.view)
    
    // 4.
    child.didMove(toParent: self)
  }

  /// Remove a vc previously added from the children
  func remove(_ child: UIViewController) {
    child.willMove(toParent: nil)
    child.view.removeFromSuperview()
    child.removeFromParent()
  }
}
