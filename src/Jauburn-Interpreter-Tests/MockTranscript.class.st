"
Mock transcript for testing purposes.
"
Class {
	#name : #MockTranscript,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #streaming }
MockTranscript >> contents [ 
	^contents
]

{ #category : #'stop conditions' }
MockTranscript >> cr [
	contents := contents, (String with: Character cr).
]

{ #category : #initialization }
MockTranscript >> initialize [ 
	contents := ''
]

{ #category : #streaming }
MockTranscript >> show: object [
	contents := contents, object
]
