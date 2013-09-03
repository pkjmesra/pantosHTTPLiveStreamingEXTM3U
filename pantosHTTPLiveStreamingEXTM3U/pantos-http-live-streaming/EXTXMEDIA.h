//
//  EXTXMEDIA.h
//  pantosHTTPLiveStreamingEXTM3U
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

/*
EXT-X-MEDIA

The EXT-X-MEDIA tag is used to relate Playlists that contain
alternative renditions of the same content.  For example, three EXT-
X-MEDIA tags can be used to identify audio-only Playlists that
contain English, French and Spanish renditions of the same
presentation.  Or two EXT-X-MEDIA tags can be used to identify video-
only Playlists that show two different camera angles.

The EXT-X-MEDIA tag stands alone, in that it does not apply to a
particular URI in the Playlist.  Its format is:

#EXT-X-MEDIA:<attribute-list>

The following attributes are defined:

URI

The value is a quoted-string containing a URI that identifies the
Playlist file.  This attribute is optional; see Section 3.3.10.1.
 http://tools.ietf.org/html/draft-pantos-http-live-streaming-07#page-10

TYPE

The value is enumerated-string; valid strings are AUDIO and VIDEO.
If the value is AUDIO, the Playlist described by the tag MUST contain
audio media.  If the value is VIDEO, the Playlist MUST contain video
media.

GROUP-ID

The value is a quoted-string identifying a mutually-exclusive group
of renditions.  The presence of this attribute signals membership in
the group.  See Section 3.3.9.1.

LANGUAGE

The value is a quoted-string containing an RFC 5646 [RFC5646]
language tag [RFC5646] that identifies the primary language used in
 the rendition.  This attribute is optional.

 NAME

 The value is a quoted-string containing a human-readable description
 of the rendition.  If the LANGUAGE attribute is present then this
 description SHOULD be in that language.

 DEFAULT

 The value is enumerated-string; valid strings are YES and NO.  If the
 value is YES, then the client SHOULD play this rendition of the
 content in the absence of information from the user indicating a
 different choice.  This attribute is optional.  Its absence indicates
 an implicit value of NO.

 AUTOSELECT

 The value is enumerated-string; valid strings are YES and NO.  This
 attribute is optional.  Its absence indicates an implicit value of
 NO.  If the value is YES, then the client MAY choose to play this
 rendition in the absence of explicit user preference because it
 matches the current playback environment, such as chosen system
 language.

 The EXT-X-MEDIA tag appeared in version 4 of the protocol.
*/
#import <Foundation/Foundation.h>

@interface EXTXMEDIA : NSObject
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *isDefault; // Optional
@property (nonatomic, strong) NSString *autoSelect; // Optional
@property (nonatomic, strong) NSString *uri; // Optional
@property (nonatomic, strong) NSString *language; // Optional

-(id)init __attribute__((unavailable("init not available for this class")));
-(EXTXMEDIA*)initWithString:(NSString*)extInfRecordMarker;
@end
