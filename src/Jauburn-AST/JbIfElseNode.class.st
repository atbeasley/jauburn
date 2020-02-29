Class {
	#name : #JbIfElseNode,
	#superclass : #JbIfNode,
	#instVars : [
		'falseStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #api }
JbIfElseNode >> executeIn: environment [

	(condition value isKindOf: Boolean) 
	ifTrue: [  
	condition value ifTrue: (trueStatements do: [ :each | each executeIn: environment ])
						 ifFalse: (falseStatements do: [ :each | each executeIn: environment ])]

 	ifFalse: [ 
	(condition value evaluateIn: environment) 
		ifTrue: (trueStatements do: [ :each | each executeIn: environment ]) 
		ifFalse: (falseStatements do: [ :each | each executeIn: environment ]) ] .
	

]

{ #category : #accessing }
JbIfElseNode >> falseStatements [
	^ falseStatements
]

{ #category : #accessing }
JbIfElseNode >> falseStatements: anObject [
	falseStatements := anObject
]
