import Foundation
import UIKit

extension UIView {

  // layerMinXMinYCorner - top left
  // layerMaxXMinYCorner - top right
  // layerMinXMaxYCorner - bottom left
  // layerMaxXMaxYCorner - bottom right

  func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
      self.layer.cornerRadius = radius
      self.layer.maskedCorners = [CACornerMask]
  }
}
