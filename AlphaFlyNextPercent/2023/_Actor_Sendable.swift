//
//  _Actor_Sendable.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/11/16.
//
//  https://qiita.com/ryouta33/items/2a5101fa206b1ad0c808

import Foundation

private final class _Actor_Sendable: ViewController {



  override func viewDidLoad() {


  }
}

actor BankAccount {
  let accountNumber: Int
  var balance: Double

  init(accountNumber: Int, balance: Double) {
    self.accountNumber = accountNumber
    self.balance = balance
  }
}

extension BankAccount {
  enum BankError: Error {
    case insufficientFunds
  }

  func transfer(amount: Double, to other: BankAccount) throws {
    if amount > balance {
      throw BankError.insufficientFunds
    }

    print("Transferring \(amount) from \(accountNumber) to \(other.accountNumber)")

    // 残高を減らす. 自分自身のインスタンスは Actor 型でもアクセスできる.
    balance = balance - amount

    // 他の銀行口座をその分増やす.
    // クロスアクター参照（cross-actor reference）
    // Actor 型から自分のインスタンス以外の Actor 型の変数や関数にアクセスすると、コンパイルエラーになる.
    // other.balance = other.balance + amount
      // Actor-isolated property 'balance' can not be mutated on a non-isolated actor instance
  }

  func _transfer(amount: Double, to other: BankAccount) async throws {
    if amount > balance {
      throw BankError.insufficientFunds
    }

    // 自分自身のインスタンスは Actor 型でもアクセスできる.
    balance = balance - amount

    // Actor 型から自分のインスタンス以外の Actor 型の変数や関数へのアクセス.
    // 非同期関数(async) なら OK.
    // 暗黙的に、アクセスが呼び出し要求に変換され、Actor の排他制御が確保されたタイミングで処理される.
    await other.deposit(amount: amount)
  }

  func deposit(amount: Double) async { // async を外しても、呼び出し側の非同期関数(async)で排他制御が確保されているので動きはする.
    balance = balance + amount
  }

  func checkBalance(account: BankAccount) async {
    // await で非同期参照できる.
    print(await account.balance)

    // 書き込みは許可されない.
    // await account.balance = 1000.0
      // Actor-isolated property 'balance' can not be mutated on a non-isolated actor instance
  }

  func printAccount(account: BankAccount) {

    // let 定義の場合、非同期で参照する必要はない.
    print("Account #\(account.accountNumber)")
  }
}




