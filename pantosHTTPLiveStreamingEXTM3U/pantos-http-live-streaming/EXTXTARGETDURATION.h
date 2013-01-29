//
//  EXTXTARGETDURATION.h
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
 The EXT-X-TARGETDURATION tag indicates the approximate duration of
 the next media file that will be added to the main presentation.  It
 MUST appear in the Playlist file.  Its format is:

 #EXT-X-TARGETDURATION:<seconds>

 The actual duration of the media file MAY differ slightly from the
 target duration.
 
 The Playlist file MUST contain an EXT-X-TARGETDURATION tag.  It MUST
 indicate the approximate duration of the next media file to be added
 to the main presentation.  This value MUST remain constant for the
 entire presentation.  A typical target duration is 10 seconds.
 
 Simple Playlist file:
 #EXTM3U
 #EXT-X-TARGETDURATION:10
 #EXTINF:5220,
 http://media.example.com/entire.ts
 #EXT-X-ENDLIST
 
 Sliding Window Playlist, using HTTPS:
 #EXTM3U
 #EXT-X-TARGETDURATION:8
 #EXT-X-MEDIA-SEQUENCE:2680

 #EXTINF:8,
 https://priv.example.com/fileSequence2680.ts
 #EXTINF:8,
 https://priv.example.com/fileSequence2681.ts
 #EXTINF:8,
 https://priv.example.com/fileSequence2682.ts
 
 Playlist file with encrypted media files:
 #EXTM3U
 #EXT-X-MEDIA-SEQUENCE:7794
 #EXT-X-TARGETDURATION:15

 #EXT-X-KEY:METHOD=AES-128,URI="https://priv.example.com/key.php?r=52"

 #EXTINF:15,
 http://media.example.com/fileSequence7794.ts
 #EXTINF:15,
 http://media.example.com/fileSequence7795.ts
 #EXTINF:15,
 http://media.example.com/fileSequence7796.ts

 #EXT-X-KEY:METHOD=AES-128,URI="https://priv.example.com/key.php?r=53"

 #EXTINF:15,
 http://media.example.com/fileSequence7797.ts

 Variant Playlist file:
 #EXTM3U
 #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1280000
 http://example.com/low.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2560000
 http://example.com/mid.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=7680000
 http://example.com/hi.m3u8
 #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=65000,CODECS="mp4a.40.5"
 http://example.com/audio-only.m3u8
 */
#import <Foundation/Foundation.h>

@interface EXTXTARGETDURATION : NSObject

@property (nonatomic, assign) int duration;

-(id)init __attribute__((unavailable("init not available for this class")));
-(EXTXTARGETDURATION*)initWithString:(NSString*)extInfRecordMarker;

@end
