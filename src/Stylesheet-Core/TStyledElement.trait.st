"
A TStyledElement is a trait for objects that will be styled. It offers everything to resolve styleSheet.

YOU HAVE TO SEND #initializeStyle IN YOUR #initialize method and also to define instance variables and accessors for #styles and #styleSheet

"
Trait {
	#name : #TStyledElement,
	#category : #'Stylesheet-Core'
}

{ #category : #style }
TStyledElement >> addStyle: aStyleSymbol [
	self assert: aStyleSymbol isSymbol description: 'A style must be a ByteSymbol'. 
	self styles addLast: aStyleSymbol
]

{ #category : #style }
TStyledElement >> buildCompositeStyleSheetFrom: aStyleSheet [
	"realise the addition (ordered from less priority to higher) of differents styleSheet. The first one come from the upper elements. The second one is the context specific to the element. The third one is defined by the user only for this element and so is prioritary"

	"If we found at least one matching style we drop all substyles (we will then add only the matching ones)"

	^ (self styles
		inject:
			((aStyleSheet includesAnySubstyles: self styles)
				ifTrue: [ aStyleSheet withoutSubstyles ]
				ifFalse: [ aStyleSheet ])
		into: [ :returnedStyleSheet :aStyle | aStyleSheet substyles at: aStyle ifPresent: [ :subStyle | returnedStyleSheet + subStyle ] ifAbsent: [ returnedStyleSheet ] ])
		+ self styleSheet	"the stylesheet of the element is always the prioritary one"
]

{ #category : #style }
TStyledElement >> defaultStyle [
	^ self  explicitRequirement
]

{ #category : #initialization }
TStyledElement >> initializeStyle [
	self styleSheet: StyleSheet new.
	self styles: OrderedCollection new.
	self addStyle: self defaultStyle
]

{ #category : #style }
TStyledElement >> style: aStyleSymbol [
	self assert: aStyleSymbol isSymbol description: 'A style must be a ByteSymbol'. 
	self styles: { aStyleSymbol }
]

{ #category : #style }
TStyledElement >> styleSheet [
	^ self  explicitRequirement
]

{ #category : #style }
TStyledElement >> styleSheet: aStyleSheet [
	^ self  explicitRequirement
]

{ #category : #style }
TStyledElement >> styles [
	^ self  explicitRequirement
]

{ #category : #style }
TStyledElement >> styles: aCollectionOfStyles [
	^ self  explicitRequirement
]