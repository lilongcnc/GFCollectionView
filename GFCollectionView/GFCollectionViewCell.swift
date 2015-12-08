//
//  GFCollectionViewCell.swift
//  GFCollection
//
//  Created by Gosicfly on 15/12/8.
//  Copyright © 2015年 Gosicfly. All rights reserved.
//

import UIKit

class GFCollectionViewCell: UICollectionViewCell {
    
    private var _titleLabel: UILabel?
    
    var name: String? {
        didSet {
            self._titleLabel?.text = self.name
        }
    }
    
    override init(frame: CGRect) {
        self._titleLabel = UILabel()
        self._titleLabel?.textAlignment = .Center
        self._titleLabel?.textColor = UIColor.blackColor()
        self._titleLabel?.font = UIFont.systemFontOfSize(13)
        super.init(frame: frame)
        self.contentView.addSubview(self._titleLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self._titleLabel?.center = self.contentView.center
        self._titleLabel?.bounds = self.contentView.bounds
    }
}
