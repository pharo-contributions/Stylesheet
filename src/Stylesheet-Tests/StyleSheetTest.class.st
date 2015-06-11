Class {
	#name : #StyleSheetTest,
	#superclass : #TestCase,
	#instVars : [
		'styleSheet'
	],
	#category : #'Stylesheet-Tests'
}

{ #category : #tests }
StyleSheetTest >> setUp [
	styleSheet := StyleSheet new
]

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
StyleSheetTest >> testCustomizeWithoutDynamicCustomization [
	styleSheet customizeWith: #fakeEntity.
	
]

{ #category : #tests }
StyleSheetTest >> testDynamicCustomization [
	styleSheet dynamicCustomization: [ :aStyleSheet :styledElement | aStyleSheet at: #color put: Color black ].
	styleSheet customizeWith: #fakeEntity.
	self assert: (styleSheet get: #color) equals: Color black.
]

{ #category : #tests }
StyleSheetTest >> testIncludesAnySubstyles [
	self deny: (styleSheet includesAnySubstyles: #(#sub)).
	styleSheet > #sub.
	self assert: (styleSheet includesAnySubstyles: #(#sub)).
	
]

{ #category : #tests }
StyleSheetTest >> testSubstyleAttributes [
	styleSheet at: #textColor put: #red.
	styleSheet > #sub at: #textColor put: #green.
	styleSheet > #sub > #subsub at: #textColor put: #blue.
	self assert:( styleSheet get: #textColor ) equals: #red.
	self assert:( styleSheet > #sub get: #textColor ) equals: #green.
	self assert:( styleSheet > #sub > #subsub get: #textColor ) equals: #blue.
]

{ #category : #tests }
StyleSheetTest >> testSubstyleCreation [
	|  sub |
	sub := styleSheet > #sub.
	self assert: sub equals: styleSheet > #sub
]
