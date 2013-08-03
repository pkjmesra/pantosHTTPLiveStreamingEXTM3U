//
//  EXTXKEY.m
//  PlayerFileParsing
//
/**
 Copyright (c) 2011, Research2Development Inc.
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this list
 of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 Neither the name of the Research2Development Inc. nor the names of its contributors may be
 used to endorse or promote products derived from this software without specific
 prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 OF THE POSSIBILITY OF SUCH DAMAGE."
 **/
//
//

#import "EXTXKEY.h"
#import "RecordMarkerConstants.h"

@interface EXTXKEY()
{
    EncryptionMethod         _method;
    NSString                *_URI;
    NSString                *_IV;
}
@end

@implementation EXTXKEY
@synthesize Method=_method;
@synthesize URI=_URI;
@synthesize IV=_IV;

-(EXTXKEY*)initWithString:(NSString*)extInfRecordMarker
{
    self = [super init];

    if (self)
    {
        if (![extInfRecordMarker hasPrefix:HASH])
            extInfRecordMarker =[HASH stringByAppendingString:extInfRecordMarker];
        NSRange crlfRange = [extInfRecordMarker rangeOfString:CrLf];
        if (crlfRange.length <=0)
        {
            extInfRecordMarker = [extInfRecordMarker stringByReplacingOccurrencesOfString:LF withString:CrLf];
        }
        NSRange start = [extInfRecordMarker rangeOfString:EXTXKEY_RECORDMARKER];
        if (start.length >0)
        {
            NSString *allString = [extInfRecordMarker substringFromIndex:start.location + start.length];
            NSRange methodStart = [allString rangeOfString:ENCRYPTION_METHOD_KEY];
            // Try and extract method
            if (methodStart.location != NSNotFound)
            {
                NSString *method = [allString substringFromIndex:methodStart.location + methodStart.length];
                NSRange methodEnd = [method rangeOfString:COMMA];
                if (methodEnd.location != NSNotFound)
                {
                    method = [method substringToIndex:methodEnd.location];
                    if ([method isEqualToString:ENCRYPTION_METHOD_AES])
                    {
                        self.Method =AES128;
                    }
                    else if ([method isEqualToString:ENCRYPTION_METHOD_NONE])
                    {
                        self.Method=NONE;
                    }
                    else
                        self.Method=NONE;
                }
            }
            // try and extract URI
            NSRange URIStart = [allString rangeOfString:ENCRYPTION_URI_KEY];
            if (URIStart.location != NSNotFound)
            {
                NSString *uri = [allString substringFromIndex:URIStart.location + URIStart.length];
                NSRange uriEnd = [uri rangeOfString:COMMA];
                if (uriEnd.location != NSNotFound)
                {
                    self.URI = [[uri substringToIndex:uriEnd.location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                }
            }

            // Try and extract IV
            NSRange ivStart = [allString rangeOfString:ENCRYPTION_IV_KEY];
            if (ivStart.location != NSNotFound)
            {
                NSString *iv = [allString substringFromIndex:ivStart.location + ivStart.length];
                NSRange ivEnd = [iv rangeOfString:CrLf];
                if (ivEnd.location != NSNotFound)
                    self.IV = [iv substringToIndex:ivEnd.location];
            }

        }
    }
    return self;
}

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for this class"
                                 userInfo:nil];
    return nil;
}

-(NSString*)description
{
    //#EXT-X-KEY:METHOD=AES-128,URI="https://www.example.com/369000.key",IV=0x00000000000000000000000000000000
    if (self.Method==AES128)
    {
        return [NSString stringWithFormat:@"%@%@%@%@%@\"%@\"%@%@%@%@",
                EXTXKEY_RECORDMARKER,
                ENCRYPTION_METHOD_KEY,
                self.Method==AES128?ENCRYPTION_METHOD_AES:ENCRYPTION_METHOD_NONE,
                COMMA,
                ENCRYPTION_URI_KEY,
                self.URI,
                COMMA,
                ENCRYPTION_IV_KEY,
                self.IV,
                CrLf];
    }
    else // NONE
    {
        return [NSString stringWithFormat:@"%@%@%@%@",
                EXTXKEY_RECORDMARKER,
                ENCRYPTION_METHOD_KEY,
                ENCRYPTION_METHOD_NONE,
                CrLf];
    }
}

@end
