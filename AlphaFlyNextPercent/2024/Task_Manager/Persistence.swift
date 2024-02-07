//
//  Persistence.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/02/06.
//
//  https://qiita.com/Saayaman/items/ea437032afaeddd0cf50
//  立ち上げ直した方がいい


import CoreData

struct PersistenceController {
  static let shared = PersistenceController()

//  static var preview: PersistenceController {
//
//  }()

  let container : NSPersistentContainer

  init() {
    container = NSPersistentContainer(name: "Task_Manager")


  }
}
