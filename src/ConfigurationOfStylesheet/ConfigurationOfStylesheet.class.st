Class {
	#name : #ConfigurationOfStylesheet,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfStylesheet
}

{ #category : #'development support' }
ConfigurationOfStylesheet class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfStylesheet class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfStylesheet class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfStylesheet class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfStylesheet class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfStylesheet class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfStylesheet class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfStylesheet class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfStylesheet class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfStylesheet class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfStylesheet >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec 
			package: #'Stylesheet-Core';
			package: #'Stylesheet-Tests'. ].

]

{ #category : #baselines }
ConfigurationOfStylesheet >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/RMoD/Stylesheet/main/'.
		spec 
			package: #'Stylesheet-Core';
			package: #'Stylesheet-Tests'. ].

]

{ #category : #accessing }
ConfigurationOfStylesheet >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfStylesheet >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.2-baseline'.

]

{ #category : #accessing }
ConfigurationOfStylesheet >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfStylesheet >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.2'.

]

{ #category : #versions }
ConfigurationOfStylesheet >> version10: spec [
	<version: '1.0' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'GuillaumeLarcheveque'.
		spec timestamp: '2/25/2015 16:14'.
		spec 
			package: #'Stylesheet-Core' with: 'Stylesheet-Core-GuillaumeLarcheveque.1';
			package: #'Stylesheet-Tests' with: 'Stylesheet-Tests-GuillaumeLarcheveque.1'. ].

]

{ #category : #versions }
ConfigurationOfStylesheet >> version11: spec [
	<version: '1.1' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1'.
		spec author: 'GuillaumeLarcheveque'.
		spec timestamp: '2/15/2016 18:21'.
		spec 
			package: #'Stylesheet-Core' with: 'Stylesheet-Core-GuillaumeLarcheveque.10';
			package: #'Stylesheet-Tests' with: 'Stylesheet-Tests-GuillaumeLarcheveque.6'. ].

]

{ #category : #versions }
ConfigurationOfStylesheet >> version12: spec [
	<version: '1.2' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2'.
		spec author: 'GuillaumeLarcheveque'.
		spec timestamp: '7/8/2016 10:48'.
		spec 
			package: #'Stylesheet-Core' with: 'Stylesheet-Core-GuillaumeLarcheveque.13';
			package: #'Stylesheet-Tests' with: 'Stylesheet-Tests-GuillaumeLarcheveque.6'. ].

]
