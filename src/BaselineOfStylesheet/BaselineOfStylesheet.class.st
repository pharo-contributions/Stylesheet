Class {
	#name : #BaselineOfStylesheet,
	#superclass : #BaselineOf,
	#category : #BaselineOfStylesheet
}

{ #category : #baselines }
BaselineOfStylesheet >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'Stylesheet-Core';
				package: 'Stylesheet-Tests' with: [ spec requires: #('Stylesheet-Core') ].

			"Groups"
			spec
				group: 'core' with: #('Stylesheet-Core');
				group: 'tests' with: #('Stylesheet-Tests') ]
]

{ #category : #accessing }
BaselineOfStylesheet >> projectClass [
	^ [ self class environment at: #MetacelloCypressBaselineProject ]
		on: NotFound
		do: [ super projectClass ]
]
