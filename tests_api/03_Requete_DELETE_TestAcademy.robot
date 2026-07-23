*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}         https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}          Cle-API-ReqRes-test-academy            # Clé API pour l'authentification
${Id_Temp}          ${NONE}                                # Initialisé à NONE, alimenté par le setup

*** Test Cases ***
Test Requete DELETE
    [Documentation]    Vérifie la suppression d'un utilisateur via une requête DELETE.
    ...                Le setup crée un utilisateur temporaire dédié au test : aucune donnée existante n'est affectée.
    [Setup]            Creer Utilisateur Temporaire

    # 1. Préparation de la requête
    &{headers}=          Create Dictionary    Authorization=Bearer ${API_KEY}

    # 2. Exécution de la requête (cible l'utilisateur temporaire créé dans le setup)
    ${Reponse}=          DELETE    url=${Base_URL}api/users/${Id_Temp}    headers=${headers}    expected_status=204
    Log                  Utilisateur temporaire (ID: ${Id_Temp}) supprimé avec succès. Données propres.

*** Keywords ***
Creer Utilisateur Temporaire
    [Documentation]    Setup : crée un utilisateur temporaire via POST pour servir de cible au DELETE.
    &{headers}=    Create Dictionary    Authorization=Bearer ${API_KEY}
    &{Corps}=      Create Dictionary
    ...            first_name=Temporaire
    ...            last_name=ASupprimer
    ...            email=temp.delete@api.testacademy.fr
    ${Reponse}=    POST    url=${Base_URL}api/users    json=${Corps}    headers=${headers}    expected_status=201
    ${id}=         Get From Dictionary    ${Reponse.json()}    id
    Set Suite Variable    ${Id_Temp}    ${id}
    Log            Setup : utilisateur temporaire créé avec l'ID=${Id_Temp}
