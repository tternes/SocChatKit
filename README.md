# SocChatKit

An Objective-C library for connecting to [Sococo's streaming chat API](http://developer.sococo.com/). It provides an implementation of the authentication handoff and streaming connection, as well as a demo bot.


## Dependencies
* Tested on Xcode 6.1, uses ARC (except for DDComet)
* [tternes/cometclient](https://github.com/tternes/cometclient) - fork of the DDComet library with added support for cookies and relaxed polling
* [Sococo API Token](http://developer.sococo.com/pages/generating-an-api-token.html) - API token from the Sococo Console
* [Room Code](http://developer.sococo.com/pages/authentication.html) - code used to specify which room your API client will be placed in

## Getting Started

This repository contains a working echo bot, but it may be helpful to read [the developer documentation](http://developer.sococo.com/) to learn how the chat API works before writing your client.

`SCKDemoBot` basic example of how to instantiate `SCKStream`, authenticate, and respond to chat messages. Here are the highlights:

	// Create the stream object
	self.stream = [[SCKStream alloc] init];
	self.stream.delegate = self;
	
	// Connect the stream to a room (handles login automatically)
	[self.stream connectWithToken:apiToken toRoom:roomId];
	
	// Implement the SCKStream delegate methods
	- (void)stream:(SCKStream *)stream connectedToRoom:(NSString *)roomId;
	- (void)stream:(SCKStream *)stream receivedMessage:(SCKMessage *)message
	...

# License
The MIT License (MIT)

Copyright (c) 2014 Thaddeus Ternes

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.