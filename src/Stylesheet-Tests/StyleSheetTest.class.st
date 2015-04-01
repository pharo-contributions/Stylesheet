Class {
	#name : #StyleSheetTest,
	#superclass : #TestCase,
	#category : #'Stylesheet-Tests'
}

{ #category : #tests }
StyleSheetTest >> testAdditionDoNotModifyFirstStyleSheet [
	| first second result |
	first := StyleSheet new.
	first at: #textColor put: #firstColor.
	second := StyleSheet new.
	second at: #textColor put: #secondColor.
	result := first + second.
	self assert: (first get: #textColor) equals: #firstColor.
	self assert: (second get: #textColor) equals: #secondColor.
	self assert: (result get: #textColor) equals: #secondColor
]

{ #category : #tests }
StyleSheetTest >> testSubstyleAttributes [
	| base |
	base := StyleSheet new.
	base at: #textColor put: #red.
	base > #sub at: #textColor put: #green.
	base > #sub > #subsub at: #textColor put: #blue.
	self assert:( base get: #textColor ) equals: #red.
	self assert:( base > #sub get: #textColor ) equals: #green.
	self assert:( base > #sub > #subsub get: #textColor ) equals: #blue.
]

{ #category : #tests }
StyleSheetTest >> testSubstyleCreation [
	| base sub |
	base := StyleSheet new.
	sub := base > #sub.
	self assert: sub equals: base > #sub
]
