//
//  MemoModel.swift
//  SampleMemoApp
//
//  Created by Yoonjae on 2022/09/17.
//

import Foundation
import RealmSwift

// https://docs.mongodb.com/realm/sdk/ios/quick-start Realm 문서

class MemoList: Object {
    // Realm 버전10.24에서는 @objc -> @Persisted라는 property wrapper를 사용해서 persistance를 가진 데이터를 관리합니다.
    @Persisted var memoTitle: String
    @Persisted var memoContent: String?
    @Persisted var memoAll: String
    @Persisted var memoDate = Date()
    // 기본키 등록하기
    @Persisted(primaryKey: true) var _pk: ObjectId
    
    // init에서는 Designated init 과 convenience init이 존재하는데
    // 우리가 기존에 사용하는 init은 모든 프로퍼티를 초기화 해주는 Designated init에 해당합니다.
    // Convenience init은 보조 이니셜라이저에 해당하는데 파라미터 일부를 기본값으로 설정할 때 사용합니다.
    // 다만, 주의점으로는 convenience init을 사용하기 전에는 designated init이 반드시 선언이 되어야합니다.
    convenience init(memoTitle: String, memoContent: String, memoAll: String, memoDate: Date) {
        self.init()
        self.memoTitle = memoTitle
        self.memoContent = memoContent
        self.memoAll = memoAll
        self.memoDate = memoDate
    }
}
