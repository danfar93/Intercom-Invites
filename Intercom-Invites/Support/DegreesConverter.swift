import Foundation

class DegreesConverter {

  /// converts degress to radians
  /// - Parameter degree: location in degrees
  /// - Returns: Double
  func convertDegreesToRadians(degree: Double) -> Double {
      var radian = Double()
      radian = (degree * 3.14 / 180)
      return radian
  }
}
