//
//  MemoCollectionViewCell.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/26.
//

import UIKit

final class MemoCollectionViewCell: UICollectionViewCell {
    
    private let memoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    var createdDate: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        addSubview(memoImageView)
        memoImageView.constraint(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor)
        
        addSubview(titleLabel)
        titleLabel.constraint(top: memoImageView.bottomAnchor, centerX: self.centerXAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        
        addSubview(createdDate)
        createdDate.constraint(top: titleLabel.bottomAnchor, centerX: self.centerXAnchor)
    }
}
