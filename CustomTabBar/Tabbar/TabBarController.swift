//
//  TabBarController.swift
//  RnD - Personal
//
//  Created by SM Arif Ahmed on 4/2/22.
//

import UIKit

/** Globar Reff. For accessing TabBar *Hide/Show/Switch* Functions */
var TAB_BAR : TabBarController!

class TabBarController: UIViewController {
    
    /** Assign your ViewControllers to this array here */
    static let viewControllers : [UIViewController] = [GreenVC(),
                                                       RedVC(),
                                                       YellowVC(),
                                                       PurpleVC()]
    
    private var oldIndex : Int?
    
    /** For Hide and Show (Slide up/ Down) animation **/
    private var tabBarTopAnchor : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🧩 TabBar Controller Loaded")
        TAB_BAR = self
        prepareTabVarView()
        switchTab(0)
    }
    
    //MARK: - TabBarView Related
    
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
        
        /** Call back for getting the tapped Index **/
        tabBarView.tappedIndex = {[weak self] (index) in
            print("☘️ Tapped Index :",index)
            self!.switchTab(index)
        }
    }
    
    
    //MARK: - Tab Switch function
    
    /// For Switching Tabs
    /// - Parameter index: ViewController index from  *[viewControllers]*
    func switchTab(_ index : Int){
        guard index != oldIndex else { return }
        
        add(TabBarController.viewControllers[index])
        
        if let oldIndex = oldIndex {
            remove(TabBarController.viewControllers[oldIndex])
        }
        
        oldIndex = index
    }
    
    //MARK: - Hide / Show Functions
    
    /// Write your hide and show animations here
    public func hideTabbar(){
        tabBarTopAnchor.constant = 0
        UIView.animate(withDuration: 0.3, animations: view.layoutIfNeeded)
    }
    
    public func showTabbar(){
        tabBarTopAnchor.constant = -TabBarView.selfHeight
        UIView.animate(withDuration: 0.3, animations: view.layoutIfNeeded)
    }
    
    //*******************************
}

// MARK: - View Containment API

extension TabBarController {
    
    private func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        view.sendSubviewToBack(child.view)
        child.didMove(toParent: self)
    }
    
    /// Remove a vc previously added from the children
    private func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
