*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}             https://mock-api-h0g7.onrender.com/
${API_KEY}              Cle-API-ReqRes-test-academy
${FirstName_Attendu}    Janet
${LastName_Attendu}     Zion-Weaver
${Email_Attendu}        janet.zion@api.testacademy.fr
${Id_Temp}              ${NONE}    # Initialisé à NONE, alimenté par le setup

*** Test Cases ***
Test Requete PUT
    [Documentation]    Vérifie la mise à jour d'un utilisateur via une requête PUT.
    ...                Le setup crée un utilisateur temporaire et le teardown le supprime : aucune donnée existante n'est affectée.
    [Setup]            Creer Utilisateur Temporaire
    [Teardown]         Supprimer Utilisateur Temporaire

    # 1. Préparation de la requête
    &{headers}=          Create Dictionary    Authorization=Bearer ${API_KEY}
    &{Corps_Requete}=    Create Dictionary    first_name=${FirstName_Attendu}    last_name=${LastName_Attendu}    email=${Email_Attendu}

    # 2. Exécution de la requête (cible l'utilisateur temporaire créé dans le setup)
    ${Reponse}=          PUT    url=${Base_URL}api/users/${Id_Temp}    json=${Corps_Requete}    headers=${headers}    expected_status=200

    # 3. Extraction et log du corps de la réponse JSON
    ${json_reponse}=     Set Variable    ${Reponse.json()}
    Log                  ${json_reponse}

    # 4. Vérifications des données
    Dictionary Should Contain Key    ${json_reponse}    updatedAt

    ${first_name}=       Get From Dictionary    ${json_reponse}    first_name
    Should Be Equal As Strings    ${FirstName_Attendu}    ${first_name}

    ${last_name}=        Get From Dictionary    ${json_reponse}    last_name
    Should Be Equal As Strings    ${LastName_Attendu}    ${last_name}

    ${email}=            Get From Dictionary    ${json_reponse}    email
    Should Be Equal As Strings    ${Email_Attendu}    ${email}

*** Keywords ***
Creer Utilisateur Temporaire
    [Documentation]    Setup : crée un utilisateur temporaire via POST pour servir de cible au PUT.
    &{headers}=    Create Dictionary    Authorization=Bearer ${API_KEY}
    &{Corps}=      Create Dictionary
    ...            first_name=Temp
    ...            last_name=UserPut
    ...            email=temp.put@api.testacademy.fr
    ${Reponse}=    POST    url=${Base_URL}api/users    json=${Corps}    headers=${headers}    expected_status=201
    ${id}=         Get From Dictionary    ${Reponse.json()}    id
    Set Suite Variable    ${Id_Temp}    ${id}
    Log            Setup : utilisateur temporaire créé avec l'ID=${Id_Temp}

Supprimer Utilisateur Temporaire
    [Documentation]    Teardown : supprime l'utilisateur temporaire créé dans le setup. Exécuté même en cas d'échec.
    IF    $Id_Temp is not None
        &{headers}=    Create Dictionary    Authorization=Bearer ${API_KEY}
        DELETE         url=${Base_URL}api/users/${Id_Temp}    headers=${headers}    expected_status=204
        Log            Nettoyage : utilisateur temporaire ID=${Id_Temp} supprimé avec succès.
    ELSE
        Log            Nettoyage : aucun utilisateur temporaire à supprimer (setup non effectué).
    END
