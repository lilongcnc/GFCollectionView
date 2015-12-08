//
//  ViewController.swift
//  GFCollection
//
//  Created by Gosicfly on 15/12/8.
//  Copyright © 2015年 Gosicfly. All rights reserved.
//

import UIKit

class GFCollectionView: UIViewController {
    
    var menuViewCellIndex = 0 {
        willSet {
            if (self.menuViewCellIndex - newValue) < 0 {
                self.toRight = true
            } else {
                self.toRight = false
            }
        }
    }

    var toRight: Bool = true
    
    private var _itemStringArray: [String] = []
    
    private var _bottomView: UIView!

    private var _menuView: UICollectionView!
    
    private var _pageView: UICollectionView!

    func scope(closure: () -> ()) {
        closure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._itemStringArray = ["单", "身", "狗", "写", "代", "码"]
        scope {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .Horizontal
            layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width / 3, height: 40)
            
            self._menuView = UICollectionView(frame: CGRect(x: 0, y: 22, width: UIScreen.mainScreen().bounds.width, height: 40), collectionViewLayout: layout)
            self._menuView.registerClass(GFCollectionViewCell.self, forCellWithReuseIdentifier: "GFCollectionViewCell")
            self._menuView.dataSource = self
            self._menuView.delegate = self
            self._menuView.scrollEnabled = true
            self._menuView.showsHorizontalScrollIndicator = false
            self._menuView.bounces = true
            self._menuView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width * 2, height: 0)
            self._menuView.backgroundColor = UIColor.clearColor()
            
            self._bottomView = UIView(frame: CGRect(x: 0, y: self._menuView.bounds.height - 3, width: self._menuView.bounds.width / 3, height: 3))
            self._bottomView.backgroundColor = UIColor.redColor()
            self._menuView.addSubview(self._bottomView)
            self.view.addSubview(self._menuView)
        }
        scope {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .Horizontal;
            layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 62)
            self._pageView = UICollectionView(frame: CGRect(x: 0, y: 62, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 62), collectionViewLayout: layout)
            self._pageView.dataSource = self
            self._pageView.delegate = self
            self._pageView.scrollEnabled = true
            self._pageView.pagingEnabled = true
            self._pageView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width * 2, height: UIScreen.mainScreen().bounds.height - 62)
            self._pageView.bounces = true
            self._pageView.showsHorizontalScrollIndicator = false
            self._pageView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
            self.view.addSubview(self._pageView)
        }
    }

}

//MARK: -collectionViewDataSource ,collectionViewDelegate
extension GFCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._itemStringArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (collectionView == self._menuView) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GFCollectionViewCell", forIndexPath: indexPath) as! GFCollectionViewCell
            cell.name = self._itemStringArray[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UICollectionViewCell", forIndexPath: indexPath)
            let R = CGFloat(arc4random_uniform(255))/255
            let G = CGFloat(arc4random_uniform(255))/255
            let B = CGFloat(arc4random_uniform(255))/255
            cell.backgroundColor = UIColor(red: R, green: G, blue: B, alpha: 1)
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (collectionView == self._menuView) {
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? GFCollectionViewCell {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self._bottomView.frame.origin.x = cell.frame.origin.x
                    self._menuView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
                    self._pageView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
                })
            } else {
                if self.toRight {
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self._menuView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row - 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                        self._pageView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row - 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                        }, completion: { (_) -> Void in
                            UIView.animateWithDuration(0.1, animations: { () -> Void in
                                self._menuView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                                self._pageView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                            })
                    })
                } else {
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self._menuView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row + 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                        self._pageView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row + 1, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                        }, completion: { (_) -> Void in
                            UIView.animateWithDuration(0.1, animations: { () -> Void in
                                self._menuView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                                self._pageView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row, inSection: indexPath.section), atScrollPosition: .CenteredHorizontally, animated: true)
                            })
                    })
                }
                
            }
        }
    }
}

//MARK: -scrollViewDelegate
extension GFCollectionView {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (scrollView == self._pageView) {
            self.menuViewCellIndex = Int(scrollView.contentOffset.x / self._pageView.frame.size.width)
            let indexPath = NSIndexPath(forItem: self.menuViewCellIndex, inSection: 0)
            self.collectionView(self._menuView, didSelectItemAtIndexPath: indexPath)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView == self._pageView) {
            self._bottomView.frame.origin.x = scrollView.contentOffset.x / 3.0
        }
    }
}

