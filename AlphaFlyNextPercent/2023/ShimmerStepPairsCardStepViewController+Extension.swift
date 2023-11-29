////
////  ShimmerStepPairsCardStepViewController+Extension.swift
////  AlphaFlyNextPercent
////
////  Created by Daiki Takano on 2023/11/28.
////
//
//import UIKit
//import simd
//
//internal extension ShimmerStepPairsCardStepViewController {
//  struct Animator {
//    var baseBounds: CGRect
//    var elementFrame: CGRect
//    var gradientFrame: CGRect
//    var style: ShimmerViewStyle
//    var effectBeginTime: CFTimeInterval
//
//    init(
//      baseBounds: CGRect,
//      elementFrame: CGRect,
//      gradientFrame: CGRect,
//      style: ShimmerViewStyle,
//      effectBeginTime: CFTimeInterval
//    ) {
//      self.baseBounds = baseBounds
//      self.elementFrame = elementFrame
//      self.gradientFrame = gradientFrame
//      self.style = style
//      self.effectBeginTime = effectBeginTime
//    }
//
//    var effectDiameter: CGFloat {
//      return baseBounds.diagonalDistance
//    }
//
//    var effectWidth: CGFloat {
//      switch style.effectSpan {
//      case .ratio(let ratio):
//        return effectDiameter*ratio
//      case .points(let points):
//        return points
//      }
//    }
//
//    var interpolatedColors: [Any] {
//      let baseColor = style.baseColor
//      let highlightColor = style.highlightColor
//      let numberOfSteps = 30
//      let baseColors: [UIColor] = [baseColor, highlightColor, baseColor]
//      var colors: [UIColor] = []
//      for i in 0..<baseColors.count-1 {
//        let lengthOfStep = 1.0 / Float(numberOfSteps)
//        let newColors = stride(from: 0.0, to: 1.0, by: lengthOfStep).map {
//          baseColors[i].interpolate(with: baseColors[i+1], degree: CGFloat(simd_smoothstep(0.0, 1.0, $0)))
//        }
//        colors += newColors
//      }
//      colors.append(baseColors[baseColors.count-1])
//      return colors.map { $0.cgColor }
//    }
//
//    /// Effect Radius
//    /// LineA: A line passing through the center of the sync target view with angle EffectAngle.
//    /// VertexB: One closest vertex of sync target view frame from LineA.
//    /// LineC: A line passing through VertexB and intersects vertically with LineA.
//    /// PointD: The intersection point of LineA and LineC.
//    /// Effect Radius: The distance between the center of the sync target view and PointD
//    var effectRadius: CGFloat {
//      let baseAngle = atan(baseBounds.height / baseBounds.width)
//      var effectAngle = style.effectAngle.truncatingRemainder(dividingBy: .pi)
//      while effectAngle < 0 {
//        effectAngle += .pi * 2
//      }
//      effectAngle = effectAngle.truncatingRemainder(dividingBy: .pi)
//      let radius = effectDiameter / 2
//
//      switch true {
//      case effectAngle < CGFloat.pi * 0.5:
//        return abs(cos(baseAngle - effectAngle))*radius
//      default:
//        return abs(cos(baseAngle - effectAngle + CGFloat.pi * 0.5)) * radius
//      }
//    }
//
//    var vectorFromViewCenterToStartPointFrom: CGVector {
//      let distance = effectRadius + effectWidth
//      let fromVector = CGVector(dx: -distance * cos(style.effectAngle), dy: -distance * sin(style.effectAngle))
//      return fromVector
//    }
//
//    var vectorFromViewCenterToStartPointTo: CGVector {
//      let distance = effectRadius
//      let fromVector = CGVector(dx: distance * cos(style.effectAngle), dy: distance * sin(style.effectAngle))
//      return fromVector
//    }
//
//    var vectorFromViewCenterToEndPointFrom: CGVector {
//      let distance = effectRadius
//      let fromVector = CGVector(dx: -distance * cos(style.effectAngle), dy: -distance*sin(style.effectAngle))
//      return fromVector
//    }
//
//    var vectorFromViewCenterToEndPointTo: CGVector {
//      let distance = effectRadius + effectWidth
//      let fromVector = CGVector(dx: distance * cos(style.effectAngle), dy: distance * sin(style.effectAngle))
//      return fromVector
//    }
//
//    func calculateTargetPoint(with vectorFromViewCenter: CGVector) -> CGPoint {
//      // convert coordinate space from sync target view to gradient layer
//      let pointOnScope = baseBounds.mid.add(vector: vectorFromViewCenter)
//      let scopeToElement = baseBounds.origin.vector(to: elementFrame.origin)
//      let pointOnElement = pointOnScope.subtract(vector: scopeToElement)
//      let elementToGradient = CGPoint.zero.vector(to: gradientFrame.origin)
//      let converted = pointOnElement.subtract(vector: elementToGradient)
//
//      // convert point on gradient layer to ratio
//      if gradientFrame.width == 0 {
//        return .zero
//      } else {
//        return CGPoint(x: converted.x / gradientFrame.width, y: converted.y / gradientFrame.width)
//      }
//    }
//
//    var startPointAnimationFromValue: CGPoint {
//      calculateTargetPoint(with: vectorFromViewCenterToStartPointFrom)
//    }
//
//    var startPointAnimationToValue: CGPoint {
//      return calculateTargetPoint(with: vectorFromViewCenterToStartPointTo)
//    }
//
//    var endPointAnimationFromValue: CGPoint {
//      return calculateTargetPoint(with: vectorFromViewCenterToEndPointFrom)
//    }
//
//    var endPointAnimationToValue: CGPoint {
//      calculateTargetPoint(with: vectorFromViewCenterToEndPointTo)
//    }
//
//    var startPointAnimation: CABasicAnimation {
//      let animation = CABasicAnimation(keyPath: "startPoint")
//      animation.fromValue = startPointAnimationFromValue
//      animation.toValue = startPointAnimationToValue
//      animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//
//      return animation
//    }
//
//    var endPointAnimation: CABasicAnimation {
//      let animation = CABasicAnimation(keyPath: "endPoint")
//      animation.fromValue = endPointAnimationFromValue
//      animation.toValue = endPointAnimationToValue
//      animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//
//      return animation
//    }
//
//    var gradientLayerAnimation: CAAnimationGroup {
//      let groupAnimation = CAAnimationGroup()
//      groupAnimation.animations = [startPointAnimation, endPointAnimation]
//      groupAnimation.duration = style.duration
//      groupAnimation.fillMode = .both
//
//      let animation = CAAnimationGroup()
//      animation.animations = [groupAnimation]
//      animation.duration = style.duration + style.interval
//      animation.repeatCount = .infinity
//      animation.fillMode = .both
//      animation.isRemovedOnCompletion = false
//      animation.beginTime = effectBeginTime
//      return animation
//    }
//  }
//}
//
//
//
//import UIKit
//
//extension ShimmerStepPairsCardStepViewController {
//
//  /// Effect Span
//  /// Effect Span is the length of the gradation of shimmering effect.
//  /// If it is specified in ratio, the effect span in points will be calculated as SyncTargetView.frame.diagonalDistance * ratio.
//  enum EffectSpan: Equatable {
//    case ratio(CGFloat)
//    case points(CGFloat)
//  }
//}
//
//struct ShimmerViewStyle: Equatable {
//
//  /// The base color of the skelton view/shimmering effect.
//  public var baseColor: UIColor
//
//  /// The highlight color of the shimmering effect.
//  public var highlightColor: UIColor
//
//  /// The duration of the shimmering effect.
//  public var duration: CFTimeInterval
//
//  /// The interval of the shimmering effect. The length of one repetition of shimmering effect will be `duration` + `interval`.
//  public var interval: CFTimeInterval
//
//  /// The length of the gradation of shimmering effect.
//  public var effectSpan: ShimmerStepPairsCardStepViewController.EffectSpan
//
//  /// The tilt angle of the effect. Please specify using radian.
//  public var effectAngle: CGFloat
//
//  public init(baseColor: UIColor, highlightColor: UIColor, duration: CFTimeInterval, interval: CFTimeInterval, effectSpan: ShimmerStepPairsCardStepViewController.EffectSpan, effectAngle: CGFloat) {
//    self.baseColor = baseColor
//    self.highlightColor = highlightColor
//    self.duration = duration
//    self.interval = interval
//    self.effectSpan = effectSpan
//    self.effectAngle = effectAngle
//  }
//}
//
//extension ShimmerViewStyle {
//  static let `default` = ShimmerViewStyle(baseColor: UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0), highlightColor: UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0), duration: 1.2, interval: 0.4, effectSpan: .points(120), effectAngle: 0 * CGFloat.pi)
//}
