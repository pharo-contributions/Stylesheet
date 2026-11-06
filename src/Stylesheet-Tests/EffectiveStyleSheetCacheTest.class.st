Class {
	#name : 'EffectiveStyleSheetCacheTest',
	#superclass : 'TestCase',
	#instVars : [
		'root',
		'children',
		'customizations'
	],
	#category : 'Stylesheet-Tests',
	#package : 'Stylesheet-Tests'
}

{ #category : 'running' }
EffectiveStyleSheetCacheTest >> setUp [

	super setUp.
	customizations := 0.
	root := StyledElementStub new.
	root styleSheet dynamicCustomization: [ :sheet :element | customizations := customizations + 1 ].
	children := (1 to: 3) collect: [ :index |
			            StyledElementStub new
				            parent: root;
				            yourself ]
]

{ #category : 'tests' }
EffectiveStyleSheetCacheTest >> testEachElementKeepsItsOwnAttributesInTheScope [

	root styleSheet at: #color put: #black.
	children first styleSheet at: #color put: #red.
	EffectiveStyleSheetCache during: [
			self assert: (children first effectiveStyleSheet get: #color) equals: #red.
			self assert: (children second effectiveStyleSheet get: #color) equals: #black ]
]

{ #category : 'tests' }
EffectiveStyleSheetCacheTest >> testNestedScopesShareTheCacheOfTheOuterOne [

	EffectiveStyleSheetCache during: [
			children first effectiveStyleSheet.
			EffectiveStyleSheetCache during: [ children first effectiveStyleSheet ] ].
	self assert: customizations equals: 1
]

{ #category : 'tests' }
EffectiveStyleSheetCacheTest >> testNoSharedStyleSheetOutsideOfTheScope [

	self deny: children first effectiveStyleSheet identicalTo: children first effectiveStyleSheet
]

{ #category : 'tests' }
EffectiveStyleSheetCacheTest >> testParentsAreComputedForEachElementWithoutScope [

	children do: [ :child | child effectiveStyleSheet ].
	self assert: customizations equals: children size
]

{ #category : 'tests' }
EffectiveStyleSheetCacheTest >> testParentsAreComputedOnceInTheScope [
	"The elements of a tree share the style sheets of their parents, which are merged for each element when nothing keeps them"

	EffectiveStyleSheetCache during: [ children do: [ :child | child effectiveStyleSheet ] ].
	self assert: customizations equals: 1
]

{ #category : 'tests' }
EffectiveStyleSheetCacheTest >> testSameStyleSheetInTheScope [

	| first second |
	EffectiveStyleSheetCache during: [
			first := children first effectiveStyleSheet.
			second := children first effectiveStyleSheet ].
	self assert: first identicalTo: second
]

{ #category : 'tests' }
EffectiveStyleSheetCacheTest >> testScopeEndsWithItsBlock [
	"A style changed once the scope is over is seen"

	EffectiveStyleSheetCache during: [ children first effectiveStyleSheet ].
	children first styleSheet at: #width put: 77.
	self assert: (children first effectiveStyleSheet get: #width) equals: 77
]
