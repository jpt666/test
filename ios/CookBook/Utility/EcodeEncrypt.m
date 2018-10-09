//
//  EcodeEncrypt.m
//  Gopeer
//
//  Created by Samuel Huang on 12/1/15.
//  Copyright © 2015 xyxNav. All rights reserved.
//

#import "EcodeEncrypt.h"

@implementation EcodeEncrypt

static const unsigned char LTCODE_TABLE_ENHANCE[] = {7, 4, 6, 8, 1, 9, 5, 3, 10, 11, 0, 2};


+(NSString *)stringEncode:(NSString *)strInCode
{
    const char *szIn = [strInCode UTF8String];
    char szOut[13] = {0};
    
    for (int i = 0; i < 12; i++) {
        szOut[i] = szIn[LTCODE_TABLE_ENHANCE[i]];
    }
    
    NSString *strOut = [NSString stringWithUTF8String:szOut];
    return strOut;
}

+(NSString *)stringDecode:(NSString *)strInCode
{
    const char *szIn = [strInCode UTF8String];
    char szOut[13] = {0};
    
    for (int i = 0; i < 12; i++) {
        szOut[LTCODE_TABLE_ENHANCE[i]] = szIn[i];
    }
    
    NSString *strOut = [NSString stringWithUTF8String:szOut];
    return strOut;
}


+ (NSString *)encodeEnhance:(CLLocationCoordinate2D)coord
{
    int lon = coord.longitude*100000+0.5;
    int lat = coord.latitude*100000+0.5;
    
    if (lon > 10000000) {
        lon = lon - 10000000;
    }
    
    if (lon < 0) {
        lon = 0;
    } else if(lon > 0xFFFFFF) {
        lon = 0xFFFFFF;
    }
    
    if (lat < 0) {
        lat = 0;
    } else if (lat > 0xFFFFFF) {
        lat = 0xFFFFFF;
    }
    
    NSString * strLon = [NSString stringWithFormat:@"%x", lon];
    if (strLon.length < 6) {
        int num = 6 - (int)strLon.length;
        char sz[7] = {0};
        const char * szLon = [strLon UTF8String];
        
        for (int i=0; i<strLon.length; i++) {
            sz[i] = szLon[i];
        }
        
        for (int i=4; i>=0; i--) {
            if (i-num+1 >= 0) {
                sz[i+1] = sz[i-num+1];
            } else {
                sz[i+1] = '0';
            }
            
            if (i < num) {
                sz[i] = '0';
            }
        }
        strLon = [NSString stringWithUTF8String:sz];
    }
    
    
    NSString * strLat = [NSString stringWithFormat:@"%x", lat];
    if (strLat.length < 6) {
        int num = 6 - (int)strLat.length;
        char sz[7] = {0};
        const char * szLat = [strLat UTF8String];
        
        for (int i=0; i<strLat.length; i++) {
            sz[i] = szLat[i];
        }
        
        for (int i=4; i>=0; i--) {
            if (i-num+1 >= 0) {
                sz[i+1] = sz[i-num+1];
            } else {
                sz[i+1] = '0';
            }
            if (i < num) {
                sz[i] = '0';
            }
        }
        strLat = [NSString stringWithUTF8String:sz];
    }
    NSString *szCode = [NSString stringWithFormat:@"%@%@",strLat,strLon];
    
    return [self stringEncode:szCode];
}

+ (CLLocationCoordinate2D)decodeEnhance:(NSString *)ecode
{
    if (!ecode || ecode.length != 12) {
        return CLLocationCoordinate2DMake(0, 0);
    }
    
    NSString *strDecode = [self stringDecode:ecode];
    
    NSString *strLat = [strDecode substringWithRange:NSMakeRange(0, 6)];
    NSString *strLon = [strDecode substringFromIndex:6];
    
    char *szErr;
    long lat = strtol([strLat UTF8String], 0, 16);
    long lon = strtol([strLon UTF8String], &szErr, 16);
    
    if(lon < 5000000) {
        lon = lon + 10000000;
    }
    
    return CLLocationCoordinate2DMake((double)lat/100000.0, (double)lon/100000.0);
}


+ (NSString*)codeStringFromStringLinePoints:(NSString *)strLinePoints
{
    if (!strLinePoints.length) {
        return @"";
    }
    
    NSMutableString *strCode = [NSMutableString string];
    
    NSInteger arrPrevious[2] = {0};
    NSUInteger index = 0;
    
    NSArray *arrPoints = [strLinePoints componentsSeparatedByString:@";"];
    for (NSString *strPt in arrPoints) {
        NSArray *pt = [strPt componentsSeparatedByString:@","];
        //       CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[pt lastObject] doubleValue], [[pt firstObject] doubleValue]);
        
        for (int i=(int)pt.count-1; i>=0; i--) {
            NSInteger num = (NSInteger)round([[pt objectAtIndex:i] doubleValue]*100000);
            NSInteger diff = num;
            if (index > 0) {
                diff = num-arrPrevious[index%2];
            }
            arrPrevious[index%2] = num;
            num = diff;
            index++;
            num = (num<0)?~(num<<1):(num<<1);
            while (num >= 0x20) {
                [strCode appendString:[NSString stringWithFormat:@"%c", (char)((0x20|(num&0x1f))+63)]];
                num>>=5;
            }
            [strCode appendString:[NSString stringWithFormat:@"%c", (char)(num+63)]];
        }
    }
    
    return strCode;
}

+ (NSString *)strLinePointsFromCodeString:(NSString *)strCode
{
    if (!strCode.length) {
        return @"";
    }
    
    NSMutableString *strLinePoints = [NSMutableString string];
    NSUInteger len = strCode.length;
    int lat = 0, lng = 0, index = 0;
    
    const char * szCode = [strCode UTF8String];
    
    while (index < len) {
        int b, shift = 0, result = 0;
        do {
            b = szCode[index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        }while(b >= 0x20);
        
        int dlat = ((result&1) !=0? ~(result>>1):(result>>1));
        lat += dlat;
        
        shift = 0;
        result = 0;
        
        do {
            b = szCode[index++] -63;
            result |= (b&0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        
        int dlng = ((result&1) !=0? ~(result>>1):(result>>1));
        lng += dlng;
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(((double)lat/1E5), ((double)lng/1E5));
        
        if (strLinePoints.length) {
            [strLinePoints appendString:[NSString stringWithFormat:@";%lf,%lf", coord.longitude, coord.latitude]];
        } else {
            [strLinePoints appendString:[NSString stringWithFormat:@"%lf,%lf", coord.longitude, coord.latitude]];
        }
    }
    
    return strLinePoints;
}

@end
