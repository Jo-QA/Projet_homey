*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary        # Import de la bibliothèque pour la manipulation JSON
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}             https://mock-api-h0g7.onrender.com/
${API_KEY}              Cle-API-ReqRes-test-academy
${FirstName_Attendu}    Anass
${LastName_Attendu}     Rami
${Email_Attendu}        anass.rami@api.testacademy.fr
${Id_Cree}              ${NONE}    # Initialisé à NONE, alimenté après le POST pour le teardown

*** Test Cases ***
Test Requete POST
    [Documentation]    Vérifie la création d'un utilisateur via une requête POST.
    ...                Le teardown supprime automatiquement l'utilisateur créé (données propres après le test).
    [Teardown]         Supprimer Utilisateur Cree

    # 1. Préparation de la requête
    &{headers}=          Create Dictionary    Authorization=Bearer ${API_KEY}
    &{Corps_Requete}=    Create Dictionary    first_name=${FirstName_Attendu}    last_name=${LastName_Attendu}    email=${Email_Attendu}

    # 2. Exécution de la requête
    ${Reponse}=          POST    url=${Base_URL}api/users    json=${Corps_Requete}    headers=${headers}    expected_status=201

    # 3. Extraction et log du corps de la réponse JSON
    ${json_reponse}=     Set Variable    ${Reponse.json()}
    Log                  ${json_reponse}

    # 4. Vérifications des données
    Dictionary Should Contain Key    ${json_reponse}    id
    Dictionary Should Contain Key    ${json_reponse}    createdAt

    ${first_name}=       Get From Dictionary    ${json_reponse}    first_name
    Should Be Equal As Strings    ${FirstName_Attendu}    ${first_name}

    ${last_name}=        Get From Dictionary    ${json_reponse}    last_name
    Should Be Equal As Strings    ${LastName_Attendu}    ${last_name}

    ${email}=            Get From Dictionary    ${json_reponse}    email
    Should Be Equal As Strings    ${Email_Attendu}    ${email}

    # 5. Sauvegarde de l'ID créé pour le teardown (nettoyage)
    ${Id_Cree}=          Get From Dictionary    ${json_reponse}    id
    Set Suite Variable   ${Id_Cree}
    Log                  Utilisateur créé avec l'ID : ${Id_Cree}

*** Keywords ***
Supprimer Utilisateur Cree
    [Documentation]    Teardown : supprime l'utilisateur créé durant le test. Exécuté même en cas d'échec.
    IF    $Id_Cree is not None
        &{headers}=    Create Dictionary    Authorization=Bearer ${API_KEY}
        DELETE         url=${Base_URL}api/users/${Id_Cree}    headers=${headers}    expected_status=204
        Log            Nettoyage : utilisateur ID=${Id_Cree} supprimé avec succès.
    ELSE
        Log            Nettoyage : aucun utilisateur à supprimer (POST non effectué).
    END
