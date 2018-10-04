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

## Projects using Stylesheet:

- pharo-contributions/Artefact
- TelescopeSt/Telescope
- DuneSt/ChartJs