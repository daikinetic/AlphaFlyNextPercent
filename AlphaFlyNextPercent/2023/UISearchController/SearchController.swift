//
//  File.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2023/09/30.
//
//  https://youtu.be/Lb8aJa7J4BI?si=Lj40SZbD1kQljxmC

import UIKit
import MondrianLayout

class SearchController: UIViewController, UISearchResultsUpdating {

  let searchController = UISearchController()

  init() {
    super.init(nibName: nil, bundle: .init())

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    title = "Search"
    searchController.searchResultsUpdater = self
    navigationItem.searchController = searchController

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .center) {
        UIView.mock(preferredSize: .init(width: 50, height: 50))
      }
      .height(50)
    }

  }

  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text else { return }

    print(text)
  }

}

// The output obtained by using ChatGPT to search for the following wording.
// "Swift の UIKit ライブラリを用いて Storyboard を使わずに、検索画面のコードを書いてください。"

class SearchViewController:
  UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
  // MARK: - Properties
  let tableView = UITableView()
  let searchBar = UISearchBar()
  var searchResults: [String] = []

  var allData: [String] = [
    "Apple", "Google", "Amazon", "MicroSoft"
  ]

  // MARK: - Functions
  override func viewDidLoad() {
    super.viewDidLoad()

    // Configure UITableView
    tableView.delegate = self
    tableView.dataSource = self
    tableView.frame = view.bounds
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    searchResults = allData

    Mondrian.buildSubviews(on: view) {
      VStackBlock(alignment: .leading) {
        tableView

      }
      .height(view.bounds.height)
    }

    // Configure UISearchBar
    searchBar.delegate = self
    searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    tableView.tableHeaderView = searchBar
  }

  // DataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = searchResults[indexPath.row]
    cell.frame = .init(x: 0, y: 0, width: view.bounds.width, height: 40)
    return cell
  }

  // Delegate UISearchBar
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // SearchLogic
    // Update search results based on searchText and reload tableView
    if searchText.isEmpty {
      searchResults = allData

    } else {
      searchResults = searchResults.filter {
        return $0.lowercased().contains(searchText.lowercased())
      }
    }

    tableView.reloadData()
  }

}
