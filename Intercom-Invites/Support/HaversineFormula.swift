import Foundation

class HaversineFormula {

  let degreesConverter = DegreesConverter()

  /// calculates distance using haversine formula
  /// - Parameters:
  ///   - customerLat: customer latitude
  ///   - customerLong: customer longitude
  /// - Returns: Double
  func calculateDistanceUsingHaversine(customerLat: Double, customerLong: Double) -> Double {

      // Intercom Dublin Office
      let intercomLat: Double = 53.339428
      let intercomLong: Double = -6.257664

      let intercomLatRadian = degreesConverter.convertDegreesToRadians(degree: intercomLat)
      let intercomLongRadian = degreesConverter.convertDegreesToRadians(degree: intercomLong)
      let customerLatRadian = degreesConverter.convertDegreesToRadians(degree: customerLat)
      let customerLongRadian = degreesConverter.convertDegreesToRadians(degree: customerLong)

      let radiusKm: Double = 6378.0
      let deltaP = (intercomLatRadian - customerLatRadian)
      let deltaL = (intercomLongRadian - customerLongRadian)
      let a = sin(deltaP/2) * sin(deltaP/2) + cos(customerLatRadian) * cos(intercomLatRadian) * sin(deltaL/2) * sin(deltaL/2)
      let c = 2 * atan2(sqrt(a), sqrt(1-a))
      let distanceFromIntercomOffice = radiusKm * c

      return distanceFromIntercomOffice
  }
}
