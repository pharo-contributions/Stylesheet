"
A TStyledElement is a trait for objects that will be styled. It offers everything to resolve styleSheet.

YOU HAVE TO SEND #initializeStyle IN YOUR #initialize method and also to define instance variables and accessors for #styles and #styleSheet

"
Trait {
	#name : 'TStyledElement',
	#category : 'Stylesheet-Core',
	#package : 'Stylesheet-Core'
}

{ #category : 'style' }
TStyledElement >> addStyle: aStyleSymbol [
	self assert: aStyleSymbol isSymbol description: 'A style must be a ByteSymbol'. 
	self styles addLast: aStyleSymbol
]

{ #category : 'style' }
TStyledElement >> addStyle: aStyleSymbol if: condition [
	condition value
		ifTrue: [ self addStyle: aStyleSymbol ]
]

{ #category : 'style' }
TStyledElement >> buildCompositeStyleSheetFrom: aStyleSheet [
	"realise the addition (ordered from less priority to higher) of differents styleSheet. The first one come from the upper elements. The second one is the context specific to the element. The third one is defined by the user only for this element and so is prioritary"

	"If we found at least one matching style we drop all substyles (we will then add only the matching ones)"

	self styleSheet customizeWith: self referencedElement.
	^ (self styles
		inject: aStyleSheet
		into: [ :returnedStyleSheet :aStyle | 
			aStyleSheet substyles
				at: aStyle
				ifPresent: [ :subStyle | returnedStyleSheet + subStyle ]
				ifAbsent: [ returnedStyleSheet ] ]) + self styleSheet	"the stylesheet of the element is always the prioritary one"
]

{ #category : 'private' }
TStyledElement >> computeEffectiveStyleSheet [

	^ self buildCompositeStyleSheetFrom: (self parent
			   ifNil: [ self styleSheetClass new ]
			   ifNotNil: [ self parent effectiveStyleSheet ])
]

{ #category : 'style' }
TStyledElement >> defaultStyle [
	^ self  explicitRequirement
]

{ #category : 'styling' }
TStyledElement >> effectiveStyleSheet [
	"The style sheet which applies to the receiver: the one of its parent, then the ones of its styles, then its own. Inside EffectiveStyleSheetCache class>>#during: it is computed once for each element, so that the elements of a tree do not merge again the style sheets of their parents"

	^ EffectiveStyleSheetCache value
		  ifNil: [ self computeEffectiveStyleSheet ]
		  ifNotNil: [ :cache | cache at: self ifAbsentPut: [ self computeEffectiveStyleSheet ] ]
]

{ #category : 'initialization' }
TStyledElement >> initializeStyle [
	self styleSheet: self styleSheetClass new.
	self styles: OrderedCollection new.
	self addStyle: self defaultStyle
]

{ #category : 'style' }
TStyledElement >> parent [
	^ self  explicitRequirement
]

{ #category : 'accessing' }
TStyledElement >> referencedElement [
	^ self
]

{ #category : 'style' }
TStyledElement >> removeStyle: aStyleSymbol [
	self assert: aStyleSymbol isSymbol description: 'A style must be a ByteSymbol'.
	self styles
		remove: aStyleSymbol
		ifAbsent: [ 
			"It is allowed to ask the removing of a non present style"
			 ]
]

{ #category : 'style' }
TStyledElement >> style: aStyleSymbol [
	self assert: aStyleSymbol isSymbol description: 'A style must be a ByteSymbol'.
	self styles
		removeAll;
		add: aStyleSymbol
]

{ #category : 'style' }
TStyledElement >> styleSheet [
	^ self  explicitRequirement
]

{ #category : 'style' }
TStyledElement >> styleSheet: aStyleSheet [
	^ self  explicitRequirement
]

{ #category : 'initialization' }
TStyledElement >> styleSheetClass [
	^ StyleSheet 
]

{ #category : 'style' }
TStyledElement >> styles [
	^ self  explicitRequirement
]

{ #category : 'style' }
TStyledElement >> styles: aCollectionOfStyles [
	^ self  explicitRequirement
]
