"
A minimal styled element for the tests: it has a parent, a style sheet and styles.
"
Class {
	#name : 'StyledElementStub',
	#superclass : 'Object',
	#traits : 'TStyledElement',
	#classTraits : 'TStyledElement classTrait',
	#instVars : [
		'parent',
		'styleSheet',
		'styles'
	],
	#category : 'Stylesheet-Tests',
	#package : 'Stylesheet-Tests'
}

{ #category : 'accessing' }
StyledElementStub >> defaultStyle [
	^ #default
]

{ #category : 'initialization' }
StyledElementStub >> initialize [

	super initialize.
	self initializeStyle
]

{ #category : 'accessing' }
StyledElementStub >> parent [
	^ parent
]

{ #category : 'accessing' }
StyledElementStub >> parent: anElement [

	parent := anElement
]

{ #category : 'accessing' }
StyledElementStub >> styleSheet [
	^ styleSheet
]

{ #category : 'accessing' }
StyledElementStub >> styleSheet: aStyleSheet [
	styleSheet := aStyleSheet
]

{ #category : 'accessing' }
StyledElementStub >> styles [
	^ styles
]

{ #category : 'accessing' }
StyledElementStub >> styles: aCollectionOfStyles [
	styles := aCollectionOfStyles
]
