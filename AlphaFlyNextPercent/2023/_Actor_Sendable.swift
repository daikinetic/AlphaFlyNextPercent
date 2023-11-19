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

// クロスアクター参照で class はサポートしていない
final class Person {
  var name: String
  let birthDate: Date

  init(name: String, birthDate: Date) {
    self.name = name
    self.birthDate = birthDate
  }
}

actor _BankAccount {
  var owners: [Person]

  init(owners: [Person]) {
    self.owners = owners
  }

  func primaryOwner() -> Person? { return owners.first }

  // Actor 型の同一インスタンス内でのアクセスは可能
  func primaryOwnerName() -> String? {
    return primaryOwner()?.name
  }
}

struct Actor_Sendable {
  let account: _BankAccount

  init(account: _BankAccount) {
    self.account = account
  }

  func check() async {
    // class 型（Person）を返すのでコンパイルエラー
    if let primary = await account.primaryOwner() {
      primary.name = "The Honorable " + primary.name
    }
  }
}


extension BankAccount {

  func endOfMonth(month: Int, year: Int) {
    // MARK: detach closure は @Sendable で定義されているため、
    // MARK: closure 自身がアクター分離を行う.
    detach {
      // let transactions = await self.transactions(month: month, year: year)
      // let report = Report(accountNumber: self.accountNumber, transactions: transaction)
      // await report.email(to: self.accountOwnerEmailAddress)
    }
  }

  func close(distributingTo accounts: [BankAccount]) async {
    let transferAmount = balance / Double(accounts.count)

    // MARK: forEach は @Sendable で定義されていないため、
    // MARK: BankAccount (Actor型) がアクター分離を行う.

    // accounts.forEach { account in
      // balance = balance - transferAmount
      // await account.deposit(amount: transferAmount)
    // }
  }
}
