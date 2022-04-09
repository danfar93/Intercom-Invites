import Foundation

class DistanceValidator {

  /// checks if customer is eligible for an invite
  /// - Parameter distance: distance in meters customer is away
  /// - Returns: Bool
  func isCustomerEligibleForInvite(distance: Double) -> Bool {
    return distance < 100 ? true : false
  }
}
