# Specs

Tests effectués avec Rspec (`rspec spec/select_supplier_spec.rb` pour lancer), les tests concernant les methodes `work` et `work_all` sont temporairement commenté (voir la section `Notes`). Je n'ai pas ajouté de tests pour la classe `Supplier` étant donné qu'il s'agit d'une classe interne au fonctionnement de `SupplierSelect`.

# Notes

Petit problème rencontré concernant la formule pour calculer le `global_grade`, ce que j'avais initialement compris pour `global_grade` était que si `grade_weight` était faible, le meilleur fournisseur serait celui ayant le plus petit prix, et a l'inverse en cas de `grade_weight` élevé le meilleur fournisseur serait celui avec la meilleure note. Mais ce n'est pas ce que fait cette formule, du coup je ne sais pas bien si mon interpretation du `global_grade` est éronnée ou si  la formule est fausse. Si jamais c'était effectivement le fonctionnement attendu pour le `global_grade` alors la formule devrait plutot avoir le format : `(grade_weight * (6 - advitam_grade)) + work_price`, de cette manière, le prestataire ayant le plus petit score sera soit celui ayant le plus petit prix (dans le cas d'une pondération faible de la note), soit celui ayant la meilleure note (dans le cas d'une pondération forte de la note).

# Classe `Supplier`

J'ai fait le choix de créer une classe afin d'encapsuler les données des `suppliers`, cela me semblait plus approprié plutôt que de manipuler les data a la main.

La méthode `#to_data` est une résultante de ce choix. Pour un soucis de cohérence entre le format des données en entrée de `SelectSupplier` et le format des données en sortie de cette dernière il me semblait important de renvoyer les données sous la même forme qu'en entrée. La classe implémente donc une méthode `#to_data` qui est appelée par `SelectSupplier` pour ses retours.

# Classe `SelectSupplier`

Pour la méthode `work_all` (et par conséquent la méthode `work` aussi), j'ai pris la liberté d'exclure les fournisseurs qui ne proposait pas la prestation souhaitée, ce qui était la solution la plus simple et la plus logique.
