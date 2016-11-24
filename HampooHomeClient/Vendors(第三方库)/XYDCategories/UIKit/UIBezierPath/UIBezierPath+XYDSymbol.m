//
//  UIBezierPath+Symbol.m
//  YeNom
//
//  Created by Kaijie Yu on 6/29/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "UIBezierPath+XYDSymbol.h"

#define XYDCGPointWithOffset(originPoint, offsetPoint) \
  CGPointMake(originPoint.x + offsetPoint.x, originPoint.y + offsetPoint.y)

@implementation UIBezierPath (XYDSymbol)

// plus
//
//     c-d
//     | |
//  a--b e--f
//  |       |
//  l--k h--g
//     | |
//     j-i
//
+ (UIBezierPath *)xyd_customBezierPathOfPlusSymbolWithRect:(CGRect)rect
                                                 scale:(CGFloat)scale {
  CGFloat height     = CGRectGetHeight(rect) * scale;
  CGFloat width      = CGRectGetWidth(rect)  * scale;
  CGFloat size       = (height < width ? height : width) * scale;
  CGFloat thick      = size / 3.f;
  CGFloat twiceThick = thick * 2.f;
  
  CGPoint offsetPoint =
    CGPointMake(CGRectGetMinX(rect) + (CGRectGetWidth(rect)  - size) / 2.f,
                CGRectGetMinY(rect) + (CGRectGetHeight(rect) - size) / 2.f);
  
  UIBezierPath * path = [self bezierPath];
  [path moveToPoint:XYDCGPointWithOffset(CGPointMake(0.f, thick), offsetPoint)];                // a
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(thick, thick), offsetPoint)];           // b
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(thick, 0.f), offsetPoint)];             // c
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(twiceThick, 0.f), offsetPoint)];        // d
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(twiceThick, thick), offsetPoint)];      // e
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(size, thick), offsetPoint)];            // f
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(size, twiceThick), offsetPoint)];       // g
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(twiceThick, twiceThick), offsetPoint)]; // h
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(twiceThick, size), offsetPoint)];       // i
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(thick, size), offsetPoint)];            // j
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(thick, twiceThick), offsetPoint)];      // k
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, twiceThick), offsetPoint)];        // l
  [path closePath];
  return path;
}

// minus
+ (UIBezierPath *)xyd_customBezierPathOfMinusSymbolWithRect:(CGRect)rect
                                                  scale:(CGFloat)scale {
  CGFloat height = CGRectGetHeight(rect) * scale;
  CGFloat width  = CGRectGetWidth(rect)  * scale;
  CGFloat size   = height < width ? height : width;
  CGFloat thick  = size / 3.f;
  
  return [self bezierPathWithRect:
            CGRectOffset(CGRectMake(0.f, thick, size, thick),
                         CGRectGetMinX(rect) + (CGRectGetWidth(rect)  - width)  / 2.f,
                         CGRectGetMinY(rect) + (CGRectGetHeight(rect) - height) / 2.f)];
}

// check
//
//       /---------> degree = 90˚  |
//       |                         |      /----> topPointOffset = thick / √2
//   /---(----/----> thick         |    |<->|
//   |   |    |                    |    |  /b
//   |   |   d\e                   |    | /  \
//   |   |  / /                    |    a/    \
//  a/b  | / /                     |     \     \
//   \ \  / /                      |
//    \ \c /
//     \ -/--------> bottomHeight = thick * √2
//      \/
//      f     |
//      |<--->|
//         \-------> bottomMarginRight = height - topPointOffset
//
+ (UIBezierPath *)xyd_customBezierPathOfCheckSymbolWithRect:(CGRect)rect
                                                  scale:(CGFloat)scale
                                                  thick:(CGFloat)thick {
  CGFloat height, width;
  // height : width = 32 : 25
  if (CGRectGetHeight(rect) > CGRectGetWidth(rect)) {
    height = CGRectGetHeight(rect) * scale;
    width  = height * 32.f / 25.f;
  }
  else {
    width  = CGRectGetWidth(rect) * scale;
    height = width * 25.f / 32.f;
  }
  
  CGFloat topPointOffset    = thick / sqrt(2.f);
  CGFloat bottomHeight      = thick * sqrt(2.f);
  CGFloat bottomMarginRight = height - topPointOffset;
  CGFloat bottomMarginLeft  = width - bottomMarginRight;
  
  CGPoint offsetPoint =
    CGPointMake(CGRectGetMinX(rect) + (CGRectGetWidth(rect)  - width)  / 2.f,
                CGRectGetMinY(rect) + (CGRectGetHeight(rect) - height) / 2.f);
  
  UIBezierPath * path = [self bezierPath];
  [path moveToPoint:
    XYDCGPointWithOffset(CGPointMake(0.f, height - bottomMarginLeft), offsetPoint)];                             // a
  [path addLineToPoint:
    XYDCGPointWithOffset(CGPointMake(topPointOffset, height - bottomMarginLeft - topPointOffset), offsetPoint)]; // b
  [path addLineToPoint:
    XYDCGPointWithOffset(CGPointMake(bottomMarginLeft, height - bottomHeight), offsetPoint)];                    // c
  [path addLineToPoint:
    XYDCGPointWithOffset(CGPointMake(width - topPointOffset, 0.f), offsetPoint)];                                // d
  [path addLineToPoint:
    XYDCGPointWithOffset(CGPointMake(width, topPointOffset), offsetPoint)];                                      // e
  [path addLineToPoint:
    XYDCGPointWithOffset(CGPointMake(bottomMarginLeft, height), offsetPoint)];                                   // f
  [path closePath];
  return path;
}

// cross
//
//                /---> thick |
//     b       d /            |      b
//   a/ \     / \e            |     /|\
//    \  \   /  /             |    / |_/----> offset = thick / √2
//     \  \c/  /              |  a/__|  \
//      \     /               |   \      \
//       \l f/                |___________________________________
//       /   \                |
//      /  i  \               |      c  /---> thick
//     /  / \  \              |      |\/
//   k/  /   \  \g            |   l  |_\f
//    \ /     \ /             |       \----> offset
//     j       h              |      i
//
+ (UIBezierPath *)xyd_customBezierPathOfCrossSymbolWithRect:(CGRect)rect
                                                  scale:(CGFloat)scale
                                                  thick:(CGFloat)thick {
  CGFloat height     = CGRectGetHeight(rect) * scale;
  CGFloat width      = CGRectGetWidth(rect)  * scale;
  CGFloat halfHeight = height / 2.f;
  CGFloat halfWidth  = width  / 2.f;
  CGFloat size       = height < width ? height : width;
  CGFloat offset     = thick / sqrt(2.f);
  
  CGPoint offsetPoint =
    CGPointMake(CGRectGetMinX(rect) + (CGRectGetWidth(rect)  - size) / 2.f,
                CGRectGetMinY(rect) + (CGRectGetHeight(rect) - size) / 2.f);
  
  UIBezierPath * path = [UIBezierPath bezierPath];
  [path moveToPoint:XYDCGPointWithOffset(CGPointMake(0.f, offset), offsetPoint)];                       // a
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(offset, 0.f), offsetPoint)];                    // b
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(halfWidth, halfHeight - offset), offsetPoint)]; // c
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width - offset, 0.f), offsetPoint)];            // d
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, offset), offsetPoint)];                  // e
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(halfWidth + offset, halfHeight), offsetPoint)]; // f
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, height - offset), offsetPoint)];         // g
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width - offset, height), offsetPoint)];         // h
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(halfWidth, halfHeight + offset), offsetPoint)]; // i
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(offset, height), offsetPoint)];                 // j
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, height - offset), offsetPoint)];           // k
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(halfWidth - offset, halfHeight), offsetPoint)]; // l
  [path closePath];
  return path;
}

// arrow
//
//            /----> thick
// LEFT:    b-c                  RIGHT:   b-c
//         / /                             \ \
//       a/ /d                             a\ \d
//        \ \                               / /
//         \ \                             / /
//          f-e                           f-e
//
//
// UP:       a                   DOWN:  f      b
//          /\                          |\    /|
//         / d\                         | \  / |
//       f/ /\ \b                       e\ \/ /c
//       | /  \ |                         \ a/
//       |/    \|                          \/
//       e      c                           d
//
+ (UIBezierPath *)xyd_customBezierPathOfArrowSymbolWithRect:(CGRect)rect
                                                  scale:(CGFloat)scale
                                                  thick:(CGFloat)thick
                                              direction:(XYDUIBezierPathArrowDirection)direction {
  CGFloat height     = CGRectGetHeight(rect) * scale;
  CGFloat width      = CGRectGetWidth(rect)  * scale;
  CGFloat halfHeight = height / 2.f;
  CGFloat halfWidth  = width  / 2.f;
  
  CGPoint offsetPoint =
    CGPointMake(CGRectGetMinX(rect) + (CGRectGetWidth(rect)  - width)  / 2.f,
                CGRectGetMinY(rect) + (CGRectGetHeight(rect) - height) / 2.f);
  
  UIBezierPath * path = [self bezierPath];
  if (direction == kUIBezierPathArrowDirectionLeft || direction == kUIBezierPathArrowDirectionRight) {
    if (direction == UISwipeGestureRecognizerDirectionLeft) {
      [path moveToPoint:XYDCGPointWithOffset(CGPointMake(0.f, halfHeight), offsetPoint)];          // a
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width - thick, 0.f), offsetPoint)];    // b
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, 0.f), offsetPoint)];            // c
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(thick, halfHeight), offsetPoint)];     // d
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, height), offsetPoint)];         // e
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width - thick, height), offsetPoint)]; // f
    }
    else {
      [path moveToPoint:XYDCGPointWithOffset(CGPointMake(width - thick, halfHeight), offsetPoint)]; // a
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, 0.f), offsetPoint)];               // b
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(thick, 0.f), offsetPoint)];             // c
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, halfHeight), offsetPoint)];      // d
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(thick, height), offsetPoint)];          // e
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, height), offsetPoint)];            // f
    }
  }
  else {
    if (direction == kUIBezierPathArrowDirectionUp) {
      [path moveToPoint:XYDCGPointWithOffset(CGPointMake(halfWidth, 0.f), offsetPoint)];           // a
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, height - thick), offsetPoint)]; // b
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, height), offsetPoint)];         // c
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(halfWidth, thick), offsetPoint)];      // d
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, height), offsetPoint)];           // e
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, height - thick), offsetPoint)];   // f
    }
    else {
      [path moveToPoint:XYDCGPointWithOffset(CGPointMake(halfWidth, height - thick), offsetPoint)]; // a
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, 0.f), offsetPoint)];             // b
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, thick), offsetPoint)];           // c
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(halfWidth, height), offsetPoint)];      // d
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, thick), offsetPoint)];             // e
      [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, 0.f), offsetPoint)];               // f
    }
  }
  [path closePath];
  return path;
}

// pencil
//
//       c  /---> thick
//       /\/
//      /  \d
//     /   /
//   b/   /
//   |   /
//  a|__/e
//     \--------> edgeWidth = thick / √2
//
+ (UIBezierPath *)xyd_customBezierPathOfPencilSymbolWithRect:(CGRect)rect
                                                   scale:(CGFloat)scale
                                                   thick:(CGFloat)thick {
  CGFloat height    = CGRectGetHeight(rect) * scale;
  CGFloat width     = CGRectGetWidth(rect)  * scale;
  CGFloat edgeWidth = thick / sqrt(2.f);
  
  CGPoint offsetPoint =
    CGPointMake(CGRectGetMinX(rect) + (CGRectGetWidth(rect)  - width)  / 2.f,
                CGRectGetMinY(rect) + (CGRectGetHeight(rect) - height) / 2.f);
  
  UIBezierPath * path = [UIBezierPath bezierPath];
  [path moveToPoint:XYDCGPointWithOffset(CGPointMake(0.f, height), offsetPoint)];                // a
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(0.f, height - edgeWidth), offsetPoint)]; // b
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width - edgeWidth, 0.f), offsetPoint)];  // c
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(width, edgeWidth), offsetPoint)];        // d
  [path addLineToPoint:XYDCGPointWithOffset(CGPointMake(edgeWidth, height), offsetPoint)];       // e
  [path closePath];
  return path;
}

@end
