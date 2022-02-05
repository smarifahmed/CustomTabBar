//
//  TabBarView.swift
//  RnD - Personal
//
//  Created by SM Arif Ahmed on 4/2/22.
//

import UIKit

class TabBarView: UIView {

    /** Give your TabBar height here */
    static let selfHeight : CGFloat = 85
    
    var tappedIndex : ((Int) -> Void)?
    
    /** Elements Indicator Holder CollectionView */
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.borderWidth = 3
        collectionView.layer.borderColor = UIColor.systemPink.cgColor
        return collectionView
    }()
    
    /** Demo Dataset For collectionView*/
    private let colorSet : [UIColor] = [.systemGreen,
                                        .systemRed,
                                        .systemYellow,
                                        .systemPurple]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews(){
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TabBarCell.self, forCellWithReuseIdentifier: TabBarCell.identifier)
    }
}

extension TabBarView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TabBarController.viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCell.identifier, for: indexPath)
        cell.backgroundColor = colorSet[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tappedCell = collectionView.cellForItem(at: indexPath) as? TabBarCell else { return }
        tappedCell.showTappedAnimation()
        
        if let tappedIndex = tappedIndex{
            tappedIndex(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemCount = TabBarController.viewControllers.count
        
        let height = collectionView.frame.height
        let width = collectionView.frame.width/CGFloat(itemCount)
        
        return CGSize(width: width, height: height)
    }
    
}


extension UIView{
    
    func showTappedAnimation(){
        let tappedView = UIView()
        self.insertSubview(tappedView, at: 0)

        tappedView.translatesAutoresizingMaskIntoConstraints = false
        tappedView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tappedView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tappedView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tappedView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        tappedView.backgroundColor = .black.withAlphaComponent(0.5)
        
        UIView.animate(withDuration: 0.2) {
            tappedView.alpha = 0
        } completion: { _ in
            tappedView.removeFromSuperview()
        }
    }
}
