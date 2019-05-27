//
//  TodayController.swift
//  AppStore
//
//  Created by Will Wang on 5/26/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    
    fileprivate let cellId = "cellId"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var appFullscreenController: AppFullscreenController!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullscreenController = AppFullscreenController()
        self.appFullscreenController = appFullscreenController
        let redV = appFullscreenController.view!
        self.view.addSubview(redV)
        self.addChild(appFullscreenController)
        
        redV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        
        // Get the absolute coordinate of the cell
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.cellStartingFrame = startingFrame
        
        redV.frame = startingFrame
        redV.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            redV.frame = self.view.frame
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }
    
    var cellStartingFrame: CGRect?
    
    @objc fileprivate func handleRemoveRedView(tapGesture: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            if let frame = self.cellStartingFrame {
                tapGesture.view?.frame = frame
            }
        }, completion: { _ in
            
            tapGesture.view?.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
        })
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
