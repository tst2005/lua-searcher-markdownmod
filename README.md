
A l'inverse d'avoir "du code qui contient des commentaires a extraire pour générer de la doc"
l'idée est d'avoir "un article/texte en markdown qui contient du code" et de pouvoir executer ce code (en retirant ce qui n'est pas du code.

# sample

```lua
do
	local who = "world"
```

et la suite

```lua

	print("hello "..(who or "").."!")
end
return 123
```

Et a l'utilisation ca donne :
```bash
$ ./run-lua-in-markdown.lua README.md
hello world!
=> (number) 123
```

## autre exemple

```bash
$ ./run-lua-in-markdown.lua ./sample.md
OK
=>
```

# Security risk

There is NO specific security measure.
The lua code contains into the markdown block are extracted and executed in the main interpretor environment.


# TODO

- [x] un searcher qui prend le markdown et vire tout ce qui nest pas dans les balises de code.
- [x] que le searcher tente de charger des modules avant le contenu (de facon a avoir quelque facilité a ajouter des fonctions pratique sans qu'elles apparaissent dans le code de la page
- [ ] voir comment supporter plusieurs type de balise de code, si on garde que celle lua ?
- [ ] est-ce que github support une balise "\`\`\`lua option" ou l'on pourrait indiquer "lua sample" ou un nom de fichier "lua foo.lua"
- [ ] convertir tout ca en un module ajoutant un searcher (permettre le lua -l searcher-luainmarkdown -l README)


