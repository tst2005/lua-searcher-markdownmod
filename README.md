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

# TODO

- [x] un searcher qui prend le markdown et vire tout ce qui nest pas dans les balises de code.
- [x] que le searcher tente de charger des modules avant le contenu (de facon a avoir quelque facilité a ajouter des fonctions pratique sans qu'elles apparaissent dans le code de la page
- [ ] voir comment supporter plusieurs type de balise de code, si on garde que celle lua ?
- [ ] est-ce que github support une balise "\`\`\`lua option" ou l'on pourrait indiquer "lua sample" ou un nom de fichier "lua foo.lua"


