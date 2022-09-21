//
//  MainTableViewCell.swift
//  SampleMemoApp
//
//  Created by Yoonjae on 2022/09/15.
//

import UIKit
import Foundation
import RealmSwift

final class MemoTableViewCell: UITableViewCell {
    // Realm을 시작하기 위한 코드
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    var allTasks: Results<MemoList>!
    
    static let identifier = "MemoTableViewCell"
    
    let memoTitleLabel: UILabel = {
        let memoTitleLabel = UILabel()
        memoTitleLabel.textColor = .blue
        memoTitleLabel.font = .preferredFont(forTextStyle: .headline)
        return memoTitleLabel
    }()
    let memoDateLabel: UILabel = {
        let memoDateLabel = UILabel()
        memoDateLabel.textColor = .black
        memoDateLabel.font = .preferredFont(forTextStyle: .subheadline)
        return memoDateLabel
    }()
    let memoContentLabel: UILabel = {
        let memoContentLabel = UILabel()
        memoContentLabel.textColor = .black
        memoContentLabel.font = .preferredFont(forTextStyle: .subheadline)
        return memoContentLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addContentView()
    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}


private extension MemoTableViewCell {
    func addContentView() {
        addTitle()
        addDate()
        addContent()
    }
    
    func addTitle() {
        self.addSubview(memoTitleLabel)
        memoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            memoTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            memoTitleLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func addDate() {
        self.addSubview(memoDateLabel)
        memoDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            memoDateLabel.topAnchor.constraint(equalTo: memoTitleLabel.bottomAnchor, constant: 10),
        ])
    }
    func addContent() {
        self.addSubview(memoContentLabel)
        memoContentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoContentLabel.leadingAnchor.constraint(equalTo: memoDateLabel.trailingAnchor, constant: 30),
            memoContentLabel.topAnchor.constraint(equalTo: memoTitleLabel.bottomAnchor, constant: 10),
            memoContentLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
}

// MARK: - Preview
 #if DEBUG
 import SwiftUI
 struct MemoTableViewCellPreview: PreviewProvider {
     static var previews: some View {
         MemoTableViewCell().toPreview()
             .previewDevice("iPhone 13")
             .ignoresSafeArea()
     }
 }
 #endif

