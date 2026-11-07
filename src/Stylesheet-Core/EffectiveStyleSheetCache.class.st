"
I keep the effective style sheet of each styled element (see TStyledElement>>#effectiveStyleSheet) while a block is evaluated inside of #during:. Merging the style sheets of the parents of an element costs, and the many elements of a tree share the same parents: inside #during:, the effective style sheet of an element is computed once. Outside of it nothing is kept, so a style which changes is always seen.
"
Class {
	#name : 'EffectiveStyleSheetCache',
	#superclass : 'DynamicVariable',
	#category : 'Stylesheet-Core',
	#package : 'Stylesheet-Core'
}

{ #category : 'scoping' }
EffectiveStyleSheetCache class >> during: aBlock [
	"Evaluate aBlock with a cache of the effective style sheets of the styled elements. The styles must not change while it is evaluated. A scope inside another one uses the cache of the outer one"

	self value ifNotNil: [ ^ aBlock value ].
	^ self value: IdentityDictionary new during: aBlock
]
