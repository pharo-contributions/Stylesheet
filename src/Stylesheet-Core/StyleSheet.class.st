"
A PDFStyleSheet define style for PDFElements to separate presentation from contents. A styleSheet can have substyles to define properties specifics to a context

Instance Variables
	attributes:		<Object>
	document:		<Object>
	substyles:		<Object>

attributes
	- xxxxx

document
	- xxxxx

substyles
	- xxxxx

"
Class {
	#name : #StyleSheet,
	#superclass : #Object,
	#instVars : [
		'attributes',
		'substyles',
		'dynamicCustomization'
	],
	#category : #'Stylesheet-Core'
}

{ #category : #action }
StyleSheet >> + aStyleSheet [
	| newStyleSheet |
	newStyleSheet := self copy.
	aStyleSheet attributes keysAndValuesDo: [:aKey :aValue | newStyleSheet attributes at: aKey put: aValue ].
	aStyleSheet substyles keysAndValuesDo: [:aKey :aSubStyleSheet | newStyleSheet substyles at: aKey put: aSubStyleSheet copy ].
	newStyleSheet substyles at: #default put: newStyleSheet.
	^ newStyleSheet
]

{ #category : #accessing }
StyleSheet >> > aSymbol [
	^ self substyles at: aSymbol ifAbsentPut: [ self class new ]
]

{ #category : #private }
StyleSheet >> at: anAttribute put: aValue [
	attributes at: anAttribute put: aValue 
]

{ #category : #accessing }
StyleSheet >> attributes [
	^ attributes
]

{ #category : #copying }
StyleSheet >> copyWithout: aCollectionOfProperties [
	^ self copy removeAll: aCollectionOfProperties; yourself
]

{ #category : #customize }
StyleSheet >> customizeWith: aStyledElement [ 
	self dynamicCustomization ifNotNil: [ self dynamicCustomization cull: self cull: aStyledElement ]
]

{ #category : #accessing }
StyleSheet >> dynamicCustomization [
	^ dynamicCustomization
]

{ #category : #accessing }
StyleSheet >> dynamicCustomization: anObject [
	dynamicCustomization := anObject
]

{ #category : #private }
StyleSheet >> get: anAttribute [
	^ attributes at: anAttribute
]

{ #category : #testing }
StyleSheet >> includesAnySubstyles: aCollectionOfSubstyles [
	^ self substyles keys includesAny: aCollectionOfSubstyles 
]

{ #category : #'initialize-release' }
StyleSheet >> initialize [
	super initialize.
	attributes := Dictionary new.
	self initializeSubstyles.
]

{ #category : #'initialize-release' }
StyleSheet >> initializeSubstyles [
	substyles := Dictionary new.
	substyles at: #default put: self
]

{ #category : #copying }
StyleSheet >> postCopy [
	attributes := attributes copy.
	substyles := substyles copy.
	substyles at: #default put: self.
]

{ #category : #removing }
StyleSheet >> remove: anAttribute [
	attributes removeKey: anAttribute
]

{ #category : #removing }
StyleSheet >> removeAll: aCollectionOfAttributes [
	aCollectionOfAttributes do: [:anAttribute | self remove: anAttribute]
]

{ #category : #accessing }
StyleSheet >> substyles [
	^ substyles
]

{ #category : #accessing }
StyleSheet >> substyles: anObject [
	substyles := anObject
]

{ #category : #copying }
StyleSheet >> withoutSubstyles [
	^ self copy initializeSubstyles
]
