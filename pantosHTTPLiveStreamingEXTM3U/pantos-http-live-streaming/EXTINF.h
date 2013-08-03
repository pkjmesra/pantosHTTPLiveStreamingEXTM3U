//
//  EXTINF.h
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
/**
 The Extended M3U file format defines two tags: EXTM3U and EXTINF.  An
 Extended M3U file is distinguished from a basic M3U file by its first
 line, which MUST be #EXTM3U.

 EXTINF is a record marker that describes the media file identified by
 the URI that follows it.  Each media file URI MUST be preceded by an
 EXTINF tag.  Its format is:

 #EXTINF:<duration>,<title>

 "duration" is an integer that specifies the duration of the media
 file in seconds.  Durations SHOULD be rounded to the nearest integer.
 The remainder of the line following the comma is the title of the
 media file.
 */

#import <Foundation/Foundation.h>
#import "EXTXKEY.h"

@interface EXTINF : NSObject

@property (nonatomic, assign) int duration;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) EXTXKEY *key;
@property (nonatomic, strong) NSString *mediaFileURIExtension;

-(id)init __attribute__((unavailable("init not available for this class")));
-(EXTINF*)initWithString:(NSString*)extInfRecordMarker;
@end
