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
    var cellStartingFrame: CGRect?
    var cardView: UIView?
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullscreenController = AppFullscreenController()
        self.appFullscreenController = appFullscreenController
        
        appFullscreenController.didSelectCloseButton = {
            self.handleRemoveFullscreenCardView()
        }
        
        self.cardView = appFullscreenController.view!
        
        guard let cardView = self.cardView else {return}
        
        self.view.addSubview(cardView)
        self.addChild(appFullscreenController)
        
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveFullscreenCardView)))
        
        // Get the absolute coordinate of the cell
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.cellStartingFrame = startingFrame
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = cardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = cardView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = cardView.heightAnchor.constraint(equalToConstant: startingFrame.height)

        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        cardView.layer.cornerRadius = 16

        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }
    
    
    @objc fileprivate func handleRemoveFullscreenCardView() {

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullscreenController.tableView.contentOffset = .zero
            
            if let startingFrame = self.cellStartingFrame {
                self.topConstraint?.constant = startingFrame.origin.y
                self.leadingConstraint?.constant = startingFrame.origin.x
                self.widthConstraint?.constant = startingFrame.width
                self.heightConstraint?.constant = startingFrame.height
                self.view.layoutIfNeeded()
            }
            
        }, completion: { _ in
            self.appFullscreenController.view?.removeFromSuperview()
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
    
    static let cellSize: CGFloat = 450
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
