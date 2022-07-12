# URSSAFASSUR

Service d'aide à la gestion d'un prestataire de travaux pour accompagner les particuliers à trouver le bon prestataire et à sécuriser leurs travaux à domicile.

Le code présent est le développement d'un outil de vérification de Siret du prestataire de travaux.

Projet porté par l'[Urssaf](https://www.urssaf.fr).

Présentation du projet : https://eig.etalab.gouv.fr/defis/urssafassur/

Le programme développé est visible [ici](https://urssafassur-preview.herokuapp.com/).

## Composition Technique

  Rails 7.0.0  
  Ruby 2.7.4  
  PostgreSQL 14.0

## API Sirene - V3

Pour vérifier le siret du prestataire, ce programme s'appuie sur l'API de recherche de Siret développé par l'Insee.
La documentation de l'API est visible [ici](https://api.insee.fr/catalogue/site/themes/wso2/subthemes/insee/pages/item-info.jag?name=Sirene&version=V3&provider=insee).

Pour pouvoir faire fonctionner le programme, il est nécessaire de créer un jeton unique d'accès en se créant un compte. Toutes les informations à ce sujet se trouvent [ici](https://api.insee.fr/catalogue/site/themes/wso2/subthemes/insee/pages/help.jag#commencer).

## License

Copyright (c) 2022 Urssaf

Le code présent est publié sous la licence MIT. Permission est accordée, sans frais, à toute personne obtenant une copie de ce logiciel et des fichiers de documentation associés (le « Logiciel »), pour traiter dans le Logiciel sans restriction, y compris, sans limitation, les droits d’utiliser, copier, modifier, fusionner, publier, distribuer, sous-licencier et/ou vendre copies du Logiciel et de permettre aux personnes auxquelles le Logiciel est fourni à cet effet, sous réserve des conditions suivantes : L'avis de droit d'auteur ci-dessus et cet avis d'autorisation doivent être inclus dans tous les des copies ou des parties substantielles du Logiciel.

Pour en savoir plus sur la licence MIT : https://spdx.org/licenses/MIT.html#licenseText
