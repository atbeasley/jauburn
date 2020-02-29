Class {
	#name : #JbVariableDeclarationStatementNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #api }
JbVariableDeclarationStatementNode >> executeIn: environment [

	environment at: self identifier put: (self expression evaluateIn: environment)
]

{ #category : #accessing }
JbVariableDeclarationStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbVariableDeclarationStatementNode >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
JbVariableDeclarationStatementNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbVariableDeclarationStatementNode >> identifier: anObject [
	identifier := anObject
]
