//
//  MemoTableViewCell.swift
//  SimpleMemo_Taek
//
//  Created by 한택환 on 2022/09/09.
//

import UIKit

final class MemoTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = UILabel(frame: .zero)
    private let contentLabel: UILabel = UILabel(frame: .zero)
    private let dateLabel: UILabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// FIXME: 텍스트들 json 데이터 생성 후 교체 예정
private extension MemoTableViewCell {
    func setUpView() {
        setTitle()
        setDate()
        setContent()
    }
    
    func setTitle() {
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.text = "제목"
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setDate() {
        self.contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .preferredFont(forTextStyle: .subheadline)
        dateLabel.text = "2022. 09. 09"
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        ])
    }
    
    func setContent() {
        self.contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.font = .preferredFont(forTextStyle: .subheadline)
        contentLabel.text = "내용입니다.내용입니다.내용입니다.내용입니다.내용입니다."
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
// MARK: - Preview
#if DEBUG
import SwiftUI
struct MemoTableViewCellPreview: PreviewProvider {
    static var previews: some View {
            MemoTableViewCell().toPreview()
    }
}
#endif
