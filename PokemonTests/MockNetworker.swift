//
//  MockNetworker.swift
//  PokemonTests
//
//  Created by Sam Meech-Ward on 2018-02-21.
//  Copyright © 2018 lighthouse-labs. All rights reserved.
//

import Foundation
@testable import Pokemon

class MockNetworker: NetworkerType {
  
  var returnData: Data?
  var returnResponse: URLResponse?
  var returnError: Error?
  
  func requestData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    completionHandler(returnData, returnResponse, returnError)
  }
}
