//
//  EXTXKEY.h
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
 Media files MAY be encrypted.  The EXT-X-KEY tag provides information
 necessary to decrypt media files that follow it.  Its format is:

 #EXT-X-KEY:METHOD=<method>[,URI="<URI>"]

 The METHOD parameter specifies the encryption method.  The URI
 parameter, if present, specifies how to obtain the key.

 Version 1.0 of the protocol defines two encryption methods: NONE and
 AES-128.  An encryption method of NONE means that media files are not
 encrypted.  An encryption method of AES-128 means that media files
 are encrypted using the Advanced Encryption Standard 
 [http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf] with a
 128-bit key.

 A new EXT-X-KEY supersedes any prior EXT-X-KEY.

 If no EXT-X-KEY tag is present then media files are not encrypted.

 Key files:

 An EXT-X-KEY tag with the URI parameter identifies a Key file.  A Key
 file contains the cipher key that MUST be used to decrypt subsequent
 media files in the Playlist.

 The AES-128 encryption method uses 16-octet keys.  The format of the
 Key file is simply a packed array of these 16 octets in binary
 format.

 IV for AES-128:

 128-bit AES requires the same 16-octet Initialization Vector (IV) to
 be supplied when encrypting and decrypting.  Varying this IV
 increases the strength of the cipher.

 When using the encryption METHOD AES-128, implementations SHALL use
 the sequence number of the media file as the IV when encrypting or
 decrypting media files.  The big-endian binary representation of the
 sequence number SHALL be placed in a 16-octet buffer and padded (on
 the left) with zeros.

 Encrypting media files:
 If media files are to be encrypted the server MUST define a URI which
 will allow authorized clients to obtain a Key file containing a
 decryption key.  The Key file MUST conform to the format described above.

 The server MAY set the Expires header in the key response to indicate
 that the key may be cached.

 If the encryption METHOD is AES-128, AES-128 CBC encyption SHALL be
 applied to individual media files.  The entire file MUST be
 encrypted.  Cipher Block Chaining MUST NOT be applied across media
 files.  The sequence number of the media file MUST be used as the IV
 as described above.

 The server MUST add an EXT-X-KEY tag with the key URI to the end of
 the Playlist file.  The server MUST encrypt all subsequent media
 files with that key until a change in encryption configuration is
 desired.

 If the server wishes to switch to a new encryption key it MUST make
 the new key available via a new URI which is distinct from all
 previous key URIs used by that presentation.  It MUST add an EXT-X-
 KEY tag with the new key URI to the end of the Playlist file.  It
 MUST encrypt all subsequent media files with that key until a change
 in encryption configuration is desired.

 If the server wishes to turn off encryption it MUST add an EXT-X-KEY
 tag with the encryption METHOD NONE to the end of the Playlist file.
 It MUST NOT contain a URI parameter.  All subsequent media files MUST
 be cleartext (not encrypted) until a change in encryption
 configuration is desired.

 The server MUST NOT remove an EXT-X-KEY tag from the Playlist file if
 the Playlist file contains a URI to a media file encrypted with that
 key.

 
 Playing encrypted media files:
 If a Playlist file contains an EXT-X-KEY tag that specifies a Key
 file URI, the client MUST obtain that key file and use the key inside
 it to decrypt all media files following the EXT-X-KEY tag until
 another EXT-X-KEY tag is encountered.

 If the encryption METHOD is AES-128, AES-128 CBC decryption SHALL be
 applied to individual media files.  The entire file MUST be
 decrypted.  Cipher Block Chaining MUST NOT be applied across media
 files.  The sequence number of the media file MUST be used as the IV
 as described above.

 If the encryption METHOD is NONE, the client MUST treat all media
 files following the EXT-X-KEY tag as cleartext (not encrypted) until
 another EXT-X-KEY tag is encountered.
 */

#import <Foundation/Foundation.h>
typedef enum
{
    NONE,
    AES128
}EncryptionMethod;

@interface EXTXKEY : NSObject

@property (nonatomic, assign) EncryptionMethod Method;
@property (nonatomic, strong) NSString *URI;
@property (nonatomic, strong) NSString *IV;

-(id)init __attribute__((unavailable("init not available for this class")));
-(EXTXKEY*)initWithString:(NSString*)extInfRecordMarker;
@end
