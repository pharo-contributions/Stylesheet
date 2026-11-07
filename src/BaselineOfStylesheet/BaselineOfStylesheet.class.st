Class {
	#name : 'BaselineOfStylesheet',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfStylesheet',
	#package : 'BaselineOfStylesheet'
}

{ #category : 'baselines' }
BaselineOfStylesheet >> baseline: spec [

	<baseline>
	spec for: #common do: [
		
			self pharoBackwardCompatibility: spec.
			
			"Packages"
			spec
				package: 'Stylesheet-Core';
				package: 'Stylesheet-Tests' with: [ spec requires: #( 'Stylesheet-Core' 'PharoBackwardCompatibility') ].

			"Groups"
			spec
				group: 'core' with: #( 'Stylesheet-Core' );
				group: 'tests' with: #( 'Stylesheet-Tests' ) ]
]

{ #category : 'dependencies' }
BaselineOfStylesheet >> pharoBackwardCompatibility: spec [

	spec baseline: 'PharoBackwardCompatibility' with: [ spec repository: 'github://jecisc/PharoBackwardCompatibility:v1.x.x/src' ]
]
