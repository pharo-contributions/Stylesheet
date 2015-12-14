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

{ #category : #'initialize-release' }
StyleSheet class >> default [
	| default |
	default:= self new 
		at: #textColor put: (PDFColor r: 0 g: 0 b: 0); 
		at: #fillColor put: (PDFColor r: 255 g: 255 b: 255); 
		at: #filled put: true;
		at: #drawColor put: (PDFColor r: 0 g: 0 b: 0);
		at: #thickness put: 1 pt;
		at: #dotted put: nil;
		at: #margin put: 0 pt;
		at: #roundCap put: false;
		at: #font put: PDFHelveticaFont new;
		at: #rotation put: 0;
		at: #alignment put: PDFAlignment left middle;
		at: #opacity put: (PDFOpacityNormal alpha: 1);
		yourself.
	default > #caption at: #fillColor put: (PDFColor new setGreyLevel: 192).
	default > #datatable at: #alignment put: PDFAlignment center middle.
	default > #cell at: #margin put: 1 pt.
	default > #cell at: #alignment put: PDFAlignment center middle.
	^ default
]

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
