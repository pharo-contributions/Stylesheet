"
A style sheet for the tests which counts how many times a style sheet of its class is copied.
"
Class {
	#name : 'StyleSheetCountingCopies',
	#superclass : 'StyleSheet',
	#classVars : [
		'Copies'
	],
	#category : 'Stylesheet-Tests',
	#package : 'Stylesheet-Tests'
}

{ #category : 'accessing' }
StyleSheetCountingCopies class >> copies [

	^ Copies ifNil: [ 0 ]
]

{ #category : 'initialization' }
StyleSheetCountingCopies class >> resetCopies [

	Copies := 0
]

{ #category : 'copying' }
StyleSheetCountingCopies >> postCopy [

	super postCopy.
	Copies := self class copies + 1
]
