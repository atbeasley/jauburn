"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'printer',
		'primitives',
		'uimanager',
		'transcript'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #'as yet unclassified' }
JbInterpreter >> absBinding [

	^#abs -> [ :f |  f abs ]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [
	^ #concat -> [ :s1 :s2 | s1 , s2 ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	primitives := Set new.
	self initializeEnvBindings.
]

{ #category : #initialization }
JbInterpreter >> initializeEnvBindings [

	| primitive |
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| binding |
				binding := self perform: s.
				primitive := JbPrimitive new.
				primitive block: binding value.
				environment at: binding key put: primitive ]
]

{ #category : #primitives }
JbInterpreter >> inputBinding [
	^ #input -> [ :prompt | self uimanager request: prompt asString]

	
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
	^ #length -> [ :s | ((s isString) or: (s isArray)) ifTrue: [s size] ifFalse: [ #undefined ] ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> modBinding [

	^ #mod -> [ :a :b | (a\\b) ]
]

{ #category : #primitives }
JbInterpreter >> notBinding [
	^#not -> [ :a | a not ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^ #print -> [ :value | self transcript show: value printString ]
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [

	^#print -> [:value | self transcript show: value printString; cr]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #accessing }
JbInterpreter >> transcript [ 

	^transcript ifNil: [Transcript]
]

{ #category : #accessing }
JbInterpreter >> transcript: aTranscript [
	transcript := aTranscript
]

{ #category : #accessing }
JbInterpreter >> uimanager [
	^uimanager ifNil: [ UIManager default ]
]

{ #category : #accessing }
JbInterpreter >> uimanager: aUImanager [
	uimanager := aUImanager 
]
