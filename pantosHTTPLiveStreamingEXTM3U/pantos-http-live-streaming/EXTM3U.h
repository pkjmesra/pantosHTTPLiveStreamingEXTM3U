//
//  EXTM3U.h
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
/**
 The Extended M3U file format defines two tags: EXTM3U and EXTINF.  An
 Extended M3U file is distinguished from a basic M3U file by its first
 line, which MUST be #EXTM3U.
 
 Loading the Playlist file:
 Every time a Playlist file is loaded or reloaded from the Playlist
 URI:

 The client SHOULD check that the Playlist file begins with #EXTM3U
 and refuse to continue if it does not.  The client SHOULD ignore
 any tags it does not recognize.

 The client MUST determine the next media file to load.

 If the Playlist contains the EXT-X-MEDIA-SEQUENCE tag, the client
 SHOULD assume that each media file in it will become unavailable at
 the time that the Playlist file was loaded plus the duration of the
 Playlist file.  The duration of a Playlist file is the sum of the
 durations of the media files within it.
 
 Examples:
 MAster playlist:
 #EXTM3U
 #EXT-X-STREAM-INF:PROGRAM-ID=119,BANDWIDTH=748992,RESOLUTION=544x480,CODECS="avc1.42e01e,mp4a.40.2"
 03.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=119,BANDWIDTH=1057312,RESOLUTION=544x480,CODECS="avc1.42e01e,mp4a.40.2"
 04.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=119,BANDWIDTH=1365632,RESOLUTION=544x480,CODECS="avc1.42e01e,mp4a.40.2"
 05.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=119,BANDWIDTH=1842400,RESOLUTION=544x480,CODECS="avc1.42e01e,mp4a.40.2"
 06.m3u8

 variant playlist:
 #EXTM3U
 #EXT-X-VERSION:2
 #EXT-X-TARGETDURATION:10
 #EXT-X-MEDIA-SEQUENCE:23581
 #EXT-X-KEY:METHOD=AES-128,URI="https://www.example.com/369000.key",IV=0x00000000000000000000000000000000
 #EXTINF:10,
 20121019T194831-03-23581.ts
 #EXTINF:10,
 20121019T194831-03-23582.ts
 #EXTINF:10,
 20121019T194831-03-23583.ts
 #EXTINF:10,
 20121019T194831-03-23584.ts
 #EXTINF:10,
 20121019T194831-03-23585.ts
 #EXTINF:10,
 20121019T194831-03-23586.ts

 */
#import <Foundation/Foundation.h>
#import "EXTXVERSION.h"
#import "EXTINF.h"
#import "EXTXMEDIASEQUENCE.h"
#import "EXTXKEY.h"
#import "EXTXTARGETDURATION.h"
#import "EXTXSTREAMINF.h"

@interface EXTM3U : NSObject
#pragma mark-
#pragma mark-Master playlist
@property (nonatomic, assign, getter=isMaster) BOOL master;
//! An array of EXTXSTREAMINF objects
@property (nonatomic,strong) NSArray *variantPlaylists;

#pragma mark-
#pragma mark-variant playlist
@property (nonatomic,strong) EXTXVERSION *version;
@property (nonatomic,strong) EXTXTARGETDURATION *targetDuration;
@property (nonatomic,strong)EXTXMEDIASEQUENCE *mediaSequence;
@property (nonatomic,strong)EXTXKEY *key;
//! An array of EXTINF objects
@property (nonatomic,strong)NSArray *media;

#pragma mark-
#pragma mark-general
-(id)init __attribute__((unavailable("init not available for this class")));
-(EXTM3U*)initWithString:(NSString*)fileContents;

@end
