//
//  AuthM.swift
//  AlphaFlyNextPercent
//
//  Created by Daiki Takano on 2024/02/04.
//

import Foundation

final class SpotifyAuthM {
  static let shared = SpotifyAuthM()

  private init() {}

  var isSignedIn: Bool {
    false
  }

  private var accessToken: String? {
    nil
  }

  private var refreshToken: String? {
    nil
  }

  private var tokenExpirationDate: Date? {
    nil
  }

  private var shouldRefreshToken: Bool {
    false
  }
}
