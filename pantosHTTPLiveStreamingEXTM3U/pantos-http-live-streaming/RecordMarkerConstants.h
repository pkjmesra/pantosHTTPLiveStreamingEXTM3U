//
//  RecordMarkerConstants.h
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

#import <Foundation/Foundation.h>

#define EXTM3U_RECORDMARKER                 @"#EXTM3U"
#define EXTXVERSION_RECORDMARKER            @"#EXT-X-VERSION:"
#define EXTXMEDIA_RECORDMARKER              @"#EXT-X-MEDIA:"
#define EXTXSTREAMINF_RECORDMARKER          @"#EXT-X-STREAM-INF:"
#define EXTXTARGETDURATION_RECORDMARKER     @"#EXT-X-TARGETDURATION:"
#define EXTXMEDIASEQUENCE_RECORDMARKER      @"#EXT-X-MEDIA-SEQUENCE:"
#define EXTXKEY_RECORDMARKER                @"#EXT-X-KEY:"
#define EXTINF_RECORDMARKER                 @"#EXTINF:"
#define MEDIA_TYPE_KEY                      @"TYPE="
#define MEDIA_GROUPID_KEY                   @"GROUP-ID="
#define MEDIA_NAME_KEY                      @"NAME="
#define MEDIA_DEFAULT_KEY                   @"DEFAULT="
#define MEDIA_AUTOSELECT_KEY                @"AUTOSELECT="
#define MEDIA_URI_KEY                       @"URI="
#define MEDIA_LANGUAGE_KEY                  @"LANGUAGE="
#define STREAMINF_PROGRAMID_KEY             @"PROGRAM-ID="
#define STREAMINF_BANDWIDTH_KEY             @"BANDWIDTH="
#define STREAMINF_AUDIO_KEY                 @"AUDIO="
#define STREAMINF_RESOLUTION_KEY            @"RESOLUTION="
#define STREAMINF_CODECS_KEY                @"CODECS="
#define ENCRYPTION_METHOD_KEY               @"METHOD="
#define ENCRYPTION_URI_KEY                  @"URI="
#define ENCRYPTION_METHOD_NONE              @"NONE"
#define ENCRYPTION_METHOD_AES               @"AES-128"
#define ENCRYPTION_IV_KEY                   @"IV="
#define CR                                  @"\r"
#define LF                                  @"\n"
#define CrLf                                [NSString stringWithFormat:@"%@%@",CR,LF]
#define COMMA                               @","
#define HASH                                @"#"
#define FILEEXTENSION_MARKER                @"."
