//
//  CGFloatExtensions.swift
//  EZSwiftExtensions
//
//  Created by Cem Olcay on 12/08/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

extension CGFloat {

    /// EZSE: Return the central value of CGFloat.
    public var tt_center: CGFloat { return (self / 2) }

    /// 转角度
    public func tt_degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }

    /// 转角度
    public mutating func tt_toRadiansInPlace() {
        self = (.pi * self) / 180.0
    }

    /// EZSE: Converts angle degrees to radians.
    public static func tt_degreesToRadians(_ angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }

    /// EZSE: Converts radians to degrees.
    public func tt_radiansToDegrees() -> CGFloat {
        return (180.0 * self) / .pi
    }

    /// EZSE: Converts angle radians to degrees mutable version.
    public mutating func tt_toDegreesInPlace() {
        self = (180.0 * self) / .pi
    }

    /// EZSE : Converts angle radians to degrees static version.
    public static func tt_radiansToDegrees(_ angleInDegrees: CGFloat) -> CGFloat {
        return (180.0 * angleInDegrees) / .pi
    }

    /// EZSE: Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static func tt_random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    /// EZSE: Returns a random floating point number in the range min...max, inclusive.
    public static func tt_random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.tt_random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }

    /// EZSE: Returns a random floating point number in the range min...max, inclusive.
    public static func tt_random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.tt_random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }

    /**
      EZSE :Returns the shortest angle between two angles. The result is always between
      -π and π.

      Inspired from : https://github.com/raywenderlich/SKTUtils/blob/master/SKTUtils/CGFloat%2BExtensions.swift
     */
    public static func tt_shortestAngleInRadians(from first: CGFloat, to second: CGFloat) -> CGFloat {
        let twoPi = CGFloat(.pi * 2.0)
        var angle = (second - first).truncatingRemainder(dividingBy: twoPi)
        if angle >= .pi {
            angle -= twoPi
        }
        if angle <= -.pi {
            angle += twoPi
        }
        return angle
    }
}

#endif
