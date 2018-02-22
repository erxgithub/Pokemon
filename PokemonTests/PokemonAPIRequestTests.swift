//
//  PokemonAPIRequestTests.swift
//  PokemonTests
//
//  Created by Sam Meech-Ward on 2018-02-21.
//  Copyright © 2018 lighthouse-labs. All rights reserved.
//

import XCTest
@testable import Pokemon

class PokemonAPIRequestTests: XCTestCase {
  
  var pokemonRequest: PokemonAPIRequest!
  var networker: NetworkerType!

  override func setUp() {
    super.setUp()
    networker = MockNetworker()
    pokemonRequest = PokemonAPIRequest(networker: networker)
  }
  
  func test_buildURL_GivenAnEmptyString_ShouldReturnTheBaseURL() {
    XCTAssertEqual(pokemonRequest.buildURL(endpoint: "")!.absoluteString, "https://pokeapi.co/api/v2");
  }

  func test_buildURL_GivenAnEndpoint_ShouldReturnTheBaseURLPlusTheEndpoint() {
    XCTAssertEqual(pokemonRequest.buildURL(endpoint: "endpoint")!.absoluteString, "https://pokeapi.co/api/v2/endpoint");
  }

  func test_jsonObjectFromData_GivenEmptyData_ShouldThrowAnError() {
    let data = Data()
    XCTAssertThrowsError(try pokemonRequest.jsonObject(fromData: data))
  }
  
  func test_jsonObjectFromData_GivenInvalidJsonData_ShouldThrowAnError() {
    let invalidJSON = ""
    let data = invalidJSON.data(using: .utf8)!
    XCTAssertThrowsError(try pokemonRequest.jsonObject(fromData: data))
  }
  
  func test_jsonObjectFromData_GivenJSONObjectData_ShouldReturnJSONObject() {
    let validJSON = "{\"\":\"\"}"
    let data = validJSON.data(using: .utf8)!
    guard let result = try! pokemonRequest.jsonObject(fromData: data) as? [String: String] else {
      XCTFail("Invalid JSON returned")
      return
    }
    XCTAssertEqual(result, ["": ""])
  }
}
