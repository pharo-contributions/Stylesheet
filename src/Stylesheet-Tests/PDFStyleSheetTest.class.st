Class {
	#name : #PDFStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Stylesheet-Tests'
}

{ #category : #tests }
PDFStyleSheetTest >> testAdditionDoNotModifyFirstStyleSheet [
	| first second result |
	first := PDFStyleSheet new.
	first textColor: #firstColor.
	second := PDFStyleSheet new.
	second textColor: #secondColor.
	result := first + second.
	self assert: (first get: #textColor) equals: #firstColor.
	self assert: (second get: #textColor) equals: #secondColor.
	self assert: (result get: #textColor) equals: #secondColor
]

{ #category : #tests }
PDFStyleSheetTest >> testSubstyleAttributes [
	| base |
	base := PDFStyleSheet new.
	base at: #textColor put: #red.
	base > #sub at: #textColor put: #green.
	base > #sub > #subsub at: #textColor put: #blue.
	self assert:( base get: #textColor ) equals: #red.
	self assert:( base > #sub get: #textColor ) equals: #green.
	self assert:( base > #sub > #subsub get: #textColor ) equals: #blue.
]

{ #category : #tests }
PDFStyleSheetTest >> testSubstyleCreation [
	| base sub |
	base := PDFStyleSheet new.
	sub := base > #sub.
	self assert: sub equals: base > #sub
]
