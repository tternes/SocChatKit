# SocChatKit

An Objective-C library for connecting to [Sococo's streaming chat API](http://developer.sococo.com/). It provides an implementation of the authentication handoff and streaming connection, as well as a demo bot.


## Dependencies
* Tested on Xcode 6.1, uses ARC (except for DDComet)
* [tternes/cometclient](https://github.com/tternes/SocChatKit) - fork of the DDComet library with added support for cookies and relaxed polling
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

