//
//  PlayerReader.m
//  PlayerFileParsing
//
/**
 Copyright (c) 2011, Praveen K Jha.
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this list
 of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 Neither the name of the Praveen K Jha. nor the names of its contributors may be
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
#import "PlayerReader.h"
#import <pantosHTTPLiveStreamingEXTM3U/pantosHTTPLiveStreamingEXTM3U.h>

@implementation PlayerReader

- (id)init
{
    if((self = [super init]))
    {
    }
    return  self;
}

- (void)readAndReWriteTheFiles
{
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"tablet"
                                                          ofType:@"m3u8"];

    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"03" 
                                                          ofType:@"m3u8"];
    
    NSString *ContentOfFile1 = [NSString stringWithContentsOfFile:filePath1
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    
    NSString *ContentOfFile2 = [NSString stringWithContentsOfFile:filePath2
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
   

    EXTM3U *master = [[EXTM3U alloc] initWithString:ContentOfFile1];
    NSLog(@"master contents:\n%@",master);
    EXTM3U *variant = [[EXTM3U alloc] initWithString:ContentOfFile2];

    if (variant && !variant.isMaster)
    {
        // Let's try and change the key so it points to a local server
        variant.key.URI =@"https://127.0.0.1:8080/mykeyfilename.key";
        // Let's try and change the media file urls to absolute server urls
        for (EXTINF *inf in variant.media)
        {
            inf.title =[@"http://www22.example.com/baseurl/" stringByAppendingString:inf.title];
        }
    }

    // Now that we have made all changes, let's see what we're going to pass to
    // the native player?
    NSLog(@"Variant m3u8 contents that we'd pass to caller:\n%@",variant);
}

@end
