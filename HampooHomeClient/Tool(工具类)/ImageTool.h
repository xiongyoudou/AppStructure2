//
//  Photo.h
//  Components
//  照片处理对象
//  Created by Liu Yang on 10-9-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTool : NSObject {

}

+(float)getImageFileSize:(UIImage *)image;

/*
 * 缩放图片
 * image 图片对象
 * toWidth 宽
 * toHeight 高
 * return 返回图片对象
 */
+(UIImage *)scaleImage:(UIImage *)image toWidth:(int)toWidth toHeight:(int)toHeight;

/*
 * 缩放图片数据
 * imageData 图片数据
 * toWidth 宽
 * toHeight 高
 * return 返回图片数据对象
 */
+(NSData *)scaleData:(NSData *)imageData toWidth:(int)toWidth toHeight:(int)toHeight;

/*
 * 圆角
 * image 图片对象
 * size 尺寸
 */
+(id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;

/*
 * 图片转换为字符串
 */
+(NSString *) imageToString:(UIImage *)image;

//将image对象转换成data对象
+(NSData *) imageToDataWithJPEGRepresentation:(UIImage *)image WithQuality:(CGFloat)quality;//指定质量

+(NSData *) imageToDataWithPNGRepresentation:(UIImage *)image;

+(UIImage *)dataToImage:(NSData *)imageData;

/*
 * 字符串转换为图片
 */
+(UIImage *) stringToImage:(NSString *)string;


+ (UIImage *) createImageWithColor: (UIColor *) color;

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
+ (NSString *)base64Encoding:(NSData *)data;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+(UIImage *) imageCompress:(UIImage *)sourceImage ForMaxWidth:(CGFloat)maxWidth AndMaxHeight:(CGFloat)maxHeight;
+ (UIImage *)thumbnailImage:(UIImage *)image size:(CGSize)asize;
// 根据给定的尺寸，但是不改变图片的比例，返回图片缩略图
+ (UIImage *)thumbnailImageWithStableScale:(UIImage *)image size:(CGSize)asize;

@end
