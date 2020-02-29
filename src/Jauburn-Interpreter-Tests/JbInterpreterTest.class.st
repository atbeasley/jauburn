"
JbInterpreter
"
Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser',
		'mt'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #tests }
JbInterpreterTest >> interpret: expression assertVar: var equals: value [
	self interpret: expression.
	self assert: (interpreter environment at: var) equals: value.
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testAbs [

	self interpret: 'var x = abs(3);'.
	self assert: (interpreter environment at: 'x') equals: 3.
	self interpret: 'var x = abs(-3);'.
	self assert: (interpreter environment at: 'x') equals: 3.
]

{ #category : #tests }
JbInterpreterTest >> testConcat [

	self interpret: 'var x = concat("a","b");'.
	self assert: (interpreter environment at: 'x') equals: 'ab'.
	self interpret: 'var x = concat("ab", "cd");'.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 4 - 1 - 1;'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var x = 8 / 2 / 2;'.
	self assert: (interpreter environment at: 'x') equals: 2.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testEqualityOperators [
	
	self interpret: 'var x = 3 == 3;' assertVar: 'x' equals: true.
	self interpret: 'var x = 3 == 4;' assertVar: 'x' equals: false.
	self interpret: 'var x = 3 != 4;' assertVar: 'x' equals: true.
	self interpret: 'var x = 3 != 3;' assertVar: 'x' equals: false.
	self interpret: 'var x = 3 <= 3;' assertVar: 'x' equals: true.
	self interpret: 'var x = 3 <= 2;' assertVar: 'x' equals: false.
	self interpret: 'var x = 3 <= 4;' assertVar: 'x' equals: true.
	self interpret: 'var x = 3 < 4;' assertVar: 'x' equals: true.
	self interpret: 'var x = 3 > 4;' assertVar: 'x' equals: false.
	self interpret: 'var x = 3 < 1;' assertVar: 'x' equals: false.
	self interpret: 'var x = 3 > 1;' assertVar: 'x' equals: true.
	
]

{ #category : #tests }
JbInterpreterTest >> testFunction [

	self interpret: 'var y = 0;var x = function (a) {y = a;};'.
	self interpret: 'x(1)'.
	self assert: (interpreter environment at: 'x') equals: 1.
]

{ #category : #tests }
JbInterpreterTest >> testIf [ 
	
	self interpret: 'var no = 1==0;'.
	self interpret: 'var yes = 1==1;'.
	self interpret: 'if(true){var x = 1;};'.
	self assert: (interpreter environment at: 'x') equals: 1.
	self interpret: 'if(false){var x = 3;};'.
	self deny: (interpreter environment at: 'x') equals: 1.
	self interpret: 'if(1==1;){var x = 3;};'.
	self assert: (interpreter environment at: 'x') equals: 3.
	self interpret: 'if(no;){var x = 4;};'.
	self deny: (interpreter environment at: 'x') equals: 4.
	self interpret: 'if(not(false)){var x = 5;};'.
	self assert: (interpreter environment at: 'x') equals: 5.
	self interpret: 'if(yes;){var x = 6;};'.
	self deny: (interpreter environment at: 'x') equals: 6.
]

{ #category : #tests }
JbInterpreterTest >> testIfElse [ 
	
	self interpret: 'if(false){var x = 4;}else{var x = 9;};'.
	self assert: (interpreter environment at: 'x') equals: 9.
	self interpret: 'if(true){var x = 6;}else{var x = 10};'.
	self assert: (interpreter environment at: 'x') equals: 6.
]

{ #category : #tests }
JbInterpreterTest >> testJBArity1OperatorNode [
	
	self interpret: 'var x = -99;'.
	self assert: (interpreter environment at: 'x') equals: -99.

]

{ #category : #tests }
JbInterpreterTest >> testLength [

	self interpret: 'var x = length("one");'.
	self assert: (interpreter environment at: 'x') equals: 3.
	self interpret: 'var y = length("five");'.
	self assert: (interpreter environment at: 'y') equals: 4.
]

{ #category : #tests }
JbInterpreterTest >> testMod [

	self interpret: 'var x = mod(3,2);'.
	self assert: (interpreter environment at: 'x') equals: 1.
	self interpret: 'var y = mod(4,2);'.
	self assert: (interpreter environment at: 'y') equals: 0.
]

{ #category : #tests }
JbInterpreterTest >> testNot [

	self interpret: 'var x = not(false);' assertVar: 'x' equals: true.
	self interpret: 'var y = not(true);' assertVar: 'y' equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testPrint [ 

	mt := MockTranscript new.
	interpreter transcript: mt.
	self interpret: 'var x = print(1);'.
	self assert: (mt contents) equals: '1'.
	self interpret: 'var y = print(2);'.
	self assert: (mt contents) equals: '12'.
	self interpret: 'var y = print("hello");'.
	self assert: (mt contents) equals: '12''hello'''.
]

{ #category : #tests }
JbInterpreterTest >> testPrintln [

	mt := MockTranscript new.
	interpreter transcript: mt.
	self interpret: 'var x = print(1);'.
	self assert: (mt contents) equals: '1'.
	self interpret: 'var y = print(2);'.
	self assert: (mt contents) equals: '12'.
	self interpret: 'var y = print("hello");'.
	self assert: (mt contents) equals: '12''hello'''.
]

{ #category : #tests }
JbInterpreterTest >> testReturn [ 

	self interpret: 'var x = function (a) (a;);'.
	self interpret: 'x(1)'.
	self assert: (interpreter environment at: 'x') equals: 1.
]
