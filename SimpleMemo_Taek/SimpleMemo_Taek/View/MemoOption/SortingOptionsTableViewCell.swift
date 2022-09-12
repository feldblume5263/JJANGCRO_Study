//
//  SortingOptionsTableViewCell.swift
//  SimpleMemo_Taek
//
//  Created by 한택환 on 2022/09/11.
//

import UIKit

final class SortingOptionsTableViewCell: UITableViewCell {
    public lazy var optionLabel : UILabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpOptionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SortingOptionsTableViewCell {
    func setUpOptionView() {
        setOptionName()
    }
    
    func setOptionName() {
        self.contentView.addSubview(optionLabel)
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionLabel.font = .preferredFont(forTextStyle: .body)
        optionLabel.textColor = .black
        optionLabel.text = "제목 순으로 정렬"
        NSLayoutConstraint.activate([
            optionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            optionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            optionLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
// MARK: - Preview
#if DEBUG
import SwiftUI
struct SortingOptionsTableViewCellPreview: PreviewProvider {
    static var previews: some View {
            SortingOptionsTableViewCell().toPreview()
    }
}
#endif
