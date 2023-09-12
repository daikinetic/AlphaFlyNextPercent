//
//  AccessControlVariation.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/12.
//

import Foundation

//そのクラス間のみアクセス可能(Swift3からextension内でも利用できるようになりました。)
private let macBook = "MacBook"

//private(set)を利用すると、setはprivate、getはinternalの制限にすることができます。
private(set) var airPods = "airpods"

//一つのプロジェクト内のターゲットが同一であれば呼び出せる。継承やoverrideもできる。
internal let iPhone = "iPhone"

//同じfile内であればアクセス可能
fileprivate let imac = "iMac"

// 一つのプロジェクト内のターゲットが同一でなくても呼び出せるが継承やoverrideはできない。
public var appleWatch = "appleWatch"

//一つのプロジェクト内のターゲットが同一でなくても呼び出せるが、継承やoverrideもできる。
//open var macPro = "macPro"

//MARK: private　-> private(set) -> internal -> fileprivate -> public -> open

class Apple {
    private let macBook = "MacBook"
    private(set) var airPods = "airpods"
    internal let iPhone = "iPhone"
    fileprivate let imac = "iMac"
    public var appleWatch = "appleWatch"
    open var  macPro = "macPro"
}

extension Apple {
    public func hoge1(){
        print(macBook)
    }

    func hoge2(){
        print(macBook)
    }

    private func hoge3(){
        print(macBook)
    }
}

let apple = Apple()

// apple.iPhone
// apple.imac
// apple.macBook  //error: 'macBook' is inaccessible due to 'private' protection level
// apple.hoge1()
// apple.hoge2()
// apple.hoge3()  //error: 'hoge3' is inaccessible due to 'private' protection level




