//
//  ViewControllerTests.swift
//  PokemonTests
//
//  Created by Sam Meech-Ward on 2018-02-21.
//  Copyright © 2018 lighthouse-labs. All rights reserved.
//

import XCTest
@testable import Pokemon

class ViewControllerTests: XCTestCase {
  
  var viewController: ViewController!
  var networkManager: MockNetworker!
  
  override func setUp() {
    super.setUp()
  
    networkManager = MockNetworker()
    viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    viewController.networkManager = networkManager
  }
  
  func test_ShouldBeTheTableViewsDataSource() {
    _ = viewController.view
    XCTAssert(viewController.tableView.dataSource === viewController)
  }
  
  func test_GivenAnNetworkManagerWithPokemon_ShouldPopulateThePokemon() {
    let pokemonData = ["results": [["name": "a", "url": "b"], ["name": "1", "url": "2"]]]
    networkManager.returnData = try! JSONSerialization.data(withJSONObject: pokemonData, options: [])
    _ = viewController.view
    XCTAssertEqual(viewController.pokemons.count, 2)
  }
  
  func test_tableViewRows_ShouldEqualNumberOfPokemon() {
    viewController.pokemons = [Pokemon(name: "", url: "")]
    _ = viewController.view
    XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), viewController.pokemons.count)
  }
}
