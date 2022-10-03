//
//  MemoTableViewCell.swift
//  SimpleMemoApp_Nick
//
//  Created by Seungyun Kim on 2022/09/15.
//

import UIKit

final class MemoTableViewCell: UITableViewCell {
    
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
    
    var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        addSubview(titleLabel)
        titleLabel.constraint(top: self.topAnchor,
                              leading: self.leadingAnchor,
                              trailing: self.trailingAnchor,
                              padding: UIEdgeInsets(top: 6, left: 10, bottom: 0, right: 10))
        
        addSubview(createdDate)
        createdDate.constraint(top: titleLabel.bottomAnchor,
                               leading: self.leadingAnchor,
                               bottom: self.bottomAnchor,
                               padding: UIEdgeInsets(top: 4, left: 10, bottom: 8, right: 0))
        
        addSubview(bodyLabel)
        bodyLabel.constraint(top: titleLabel.bottomAnchor,
                             leading: createdDate.trailingAnchor,
                             bottom: self.bottomAnchor,
                             padding: UIEdgeInsets(top: 4, left: 6, bottom: 8, right: 0))
    }

}
