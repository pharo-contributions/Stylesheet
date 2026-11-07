# Stylesheet

Stylesheet is a project to define css like stylesheet in Pharo applications.

Stylesheet is written and supported by Olivier Auverlot and Guillaume Larcheveque (aka The Pasta Team) 

## Install Stylesheet 

To install Stylesheet on your Pharo image you can just execute the following script:

```Smalltalk
    Metacello new
    	githubUser: 'pharo-contributions' project: 'Stylesheet' commitish: 'master' path: 'src';
    	baseline: 'Stylesheet';
    	load
```

To add Stylesheet to your baseline just add this:

```Smalltalk
    spec
    	baseline: 'Stylesheet'
    	with: [ spec repository: 'github://pharo-contributions/Stylesheet:master/src' ]
```

Note that you can replace the #master by another branch as #development or a tag as #v1.0.0, #v1.? or #v1.2.? .

## Concepts

- A `StyleSheet` holds *attributes* (a name and a value, such as `#fontSize -> 12`) and *substyles*: named style sheets which apply only to the elements having this style.
- A *styled element* is an object that uses the trait `TStyledElement`. It has a style sheet of its own, a list of style names (`#default` at first) and optionally a parent.
- The *effective style sheet* of an element (`effectiveStyleSheet`) is what the element really uses: the effective style sheet of its parent, then the substyles matching the styles of the element, then the style sheet of the element itself. The last ones have the priority.

## Define a style sheet

```Smalltalk
styleSheet := StyleSheet new.
styleSheet
	at: #color put: Color black;
	at: #fontSize put: 12.

"A substyle: it applies to the elements which have the style #title"
titleStyle := StyleSheet new.
titleStyle at: #fontSize put: 20.
styleSheet substyles at: #title put: titleStyle.

styleSheet get: #fontSize. "12"
```

`remove:`, `removeAll:` and `copyWithout:` remove attributes. `includesAnySubstyles:` tells if some substyles exist, and `withoutSubstyles` answers a copy without them.

`+` merges two style sheets and answers a new one, the argument having the priority. The substyles are merged too, and the arguments are never modified:

```Smalltalk
merged := styleSheet + titleStyle.
merged get: #fontSize. "20"
merged get: #color. "Color black"
```

## Make an object styled

Use the trait `TStyledElement` in your class, define the slots `parent`, `styleSheet` and `styles` with their accessors, and send `initializeStyle` in `initialize`:

```Smalltalk
Object << #MyElement
	traits: { TStyledElement };
	slots: { #parent . #styleSheet . #styles };
	package: 'MyApplication'
```

```Smalltalk
MyElement >> initialize
	super initialize.
	self initializeStyle
```

The class must also answer `parent`, `parent:`, `styleSheet`, `styleSheet:`, `styles`, `styles:` and `defaultStyle` (`^ #default`). Override `styleSheetClass` to use a subclass of `StyleSheet`, and `referencedElement` when the object that is styled is not the one using the trait.

Then:

```Smalltalk
title := MyElement new.
title parent: container.
title style: #title. "Replace the styles of the element by #title"
title addStyle: #selected. "Add a style"
title addStyle: #warning if: [ hasWarning ].
title removeStyle: #selected.

title styleSheet at: #color put: Color red. "Only for this element, with the highest priority"
title effectiveStyleSheet get: #fontSize. "20, taken from the substyle #title of the parent"
```

### Attributes computed at the last moment

`dynamicCustomization:` takes a block evaluated with the style sheet and the element each time the effective style sheet is computed. It lets an element adapt its own style sheet to its state:

```Smalltalk
title styleSheet dynamicCustomization: [ :sheet :element | sheet at: #color put: element color ].
```

## Performance: compute the effective style sheets once

Computing the effective style sheet of an element merges the style sheets of all its parents. The elements of a tree share the same parents, so building a big tree computes the same merges again and again.

`EffectiveStyleSheetCache during:` keeps the effective style sheet of each element while its block is evaluated, and computes it once for each element:

```Smalltalk
EffectiveStyleSheetCache during: [ elements do: [ :element | element effectiveStyleSheet ] ]
```

Outside of the block nothing is kept, so a style that changes is always seen. In the block, the styles of the elements must not change: they would not be seen. A block inside another one uses the cache of the outer one.

## Projects using Stylesheet

- pharo-contributions/Artefact
- TelescopeSt/Telescope
- DuneSt/ChartJs

## Smalltalk versions compatibility

| Version 	| Compatible Pharo versions 		|
|----------	|---------------------------		|
| 1.x.x    	| Pharo 61, 70, 80, 90, 10, 11, 12, 13, 14, 15				|