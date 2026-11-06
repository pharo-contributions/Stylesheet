Class {
	#name : 'StyleSheetTest',
	#superclass : 'TestCase',
	#instVars : [
		'styleSheet'
	],
	#category : 'Stylesheet-Tests',
	#package : 'Stylesheet-Tests'
}

{ #category : 'tests' }
StyleSheetTest >> setUp [
	styleSheet := StyleSheet new
]

{ #category : 'tests' }
StyleSheetTest >> testAdditionCopiesTheSubstylesOfTheSecondStyleSheet [

	| first second result |
	first := StyleSheet new.
	second := StyleSheet new.
	second > #sub at: #color put: #red.
	result := first + second.
	self deny: (result substyles at: #sub) identicalTo: (second substyles at: #sub).
	result > #sub at: #color put: #blue.
	self assert: (second > #sub get: #color) equals: #red
]

{ #category : 'tests' }
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

{ #category : 'tests' }
StyleSheetTest >> testAdditionHasItselfAsItsDefaultSubstyle [

	| result |
	result := StyleSheet new + StyleSheet new.
	self assert: (result substyles at: #default) identicalTo: result
]

{ #category : 'tests' }
StyleSheetTest >> testAdditionKeepsTheSubstylesOfBothStyleSheets [

	| first second result |
	first := StyleSheet new.
	first > #firstSub at: #color put: #red.
	second := StyleSheet new.
	second > #secondSub at: #color put: #green.
	result := first + second.
	self assert: (result > #firstSub get: #color) equals: #red.
	self assert: (result > #secondSub get: #color) equals: #green
]

{ #category : 'tests' }
StyleSheetTest >> testAdditionOnlyCopiesTheFirstStyleSheetAndTheSubstylesOfTheSecondOne [
	"The default substyle of the second style sheet is the style sheet itself, and the result has its own: it is not worth a copy"

	| first second |
	first := StyleSheetCountingCopies new.
	second := StyleSheetCountingCopies new.
	second > #sub.
	StyleSheetCountingCopies resetCopies.
	first + second.
	self assert: StyleSheetCountingCopies copies equals: 2
]

{ #category : 'tests' }
StyleSheetTest >> testCopyWithout [
	| sheet copy |
	sheet := StyleSheet new.
	sheet at: #textColor put: #color.
	copy := sheet copyWithout: #(textColor).
	self assert: (sheet get: #textColor) equals: #color.
	self should: [copy get: #textColor] raise: NotFound
]

{ #category : 'tests' }
StyleSheetTest >> testCustomizeWithoutDynamicCustomization [
	styleSheet customizeWith: #fakeEntity.
	
]

{ #category : 'tests' }
StyleSheetTest >> testDynamicCustomization [
	styleSheet dynamicCustomization: [ :aStyleSheet :styledElement | aStyleSheet at: #color put: Color black ].
	styleSheet customizeWith: #fakeEntity.
	self assert: (styleSheet get: #color) equals: Color black.
]

{ #category : 'tests' }
StyleSheetTest >> testIncludesAnySubstyles [
	self deny: (styleSheet includesAnySubstyles: #(#sub)).
	styleSheet > #sub.
	self assert: (styleSheet includesAnySubstyles: #(#sub)).
	
]

{ #category : 'tests' }
StyleSheetTest >> testSubstyleAttributes [
	styleSheet at: #textColor put: #red.
	styleSheet > #sub at: #textColor put: #green.
	styleSheet > #sub > #subsub at: #textColor put: #blue.
	self assert:( styleSheet get: #textColor ) equals: #red.
	self assert:( styleSheet > #sub get: #textColor ) equals: #green.
	self assert:( styleSheet > #sub > #subsub get: #textColor ) equals: #blue.
]

{ #category : 'tests' }
StyleSheetTest >> testSubstyleCreation [
	|  sub |
	sub := styleSheet > #sub.
	self assert: sub equals: styleSheet > #sub
]
