// A category on UIBezierPath that calculates the length and a point at a given length of the path. 
//https://github.com/ImJCabus/UIBezierPath-Length
#import <UIKit/UIKit.h>

@interface UIBezierPath (XYDLength)

- (CGFloat)xyd_length;

- (CGPoint)xyd_pointAtPercentOfLength:(CGFloat)percent;

@end
