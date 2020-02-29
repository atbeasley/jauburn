Class {
	#name : #JbIfNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfNode >> condition [
	^ condition
]

{ #category : #accessing }
JbIfNode >> condition: anObject [
	condition := anObject
]

{ #category : #api }
JbIfNode >> executeIn: environment [

	(condition value isKindOf: Boolean) ifTrue: [  
	condition value ifTrue: (trueStatements do: [ :each | each executeIn: environment ]) ] ifFalse: [ 	(condition value evaluateIn: environment) ifTrue: (trueStatements do: [ :each | each executeIn: environment ]) ]
]

{ #category : #accessing }
JbIfNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbIfNode >> trueStatements: anObject [
	trueStatements := anObject
]
