//
//  Cryptx.h
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/30/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cryptx : NSObject

+ (NSData *) hmacSHA512:(NSString *)data usingKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
