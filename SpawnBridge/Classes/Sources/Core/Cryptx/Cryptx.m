//
//  Cryptx.m
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/30/17.
//

#import "Cryptx.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation Cryptx

+ (NSData *) hmacSHA512: (NSString *) data usingKey: (NSString *) key {
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    return [NSData dataWithBytes: cHMAC length: sizeof(cHMAC)];
}

@end
