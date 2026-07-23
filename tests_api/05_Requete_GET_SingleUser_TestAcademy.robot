*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary        # Import de la bibliothèque pour la manipulation JSON
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}             https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}              Cle-API-ReqRes-test-academy            # Clé API pour l'authentification
${Id_Utilisateur}       2                                      # ID de l'utilisateur à récupérer
${Email_Attendu}        janet.weaver@api.testacademy.fr        # Email attendu pour l'utilisateur ID 2
${FirstName_Attendu}    Janet                                  # Prénom attendu pour l'utilisateur ID 2
${LastName_Attendu}     Weaver                                 # Nom attendu pour l'utilisateur ID 2

*** Test Cases ***
Test 005 Requete GET Utilisateur Unique
    [Documentation]    Vérifie la récupération d'un utilisateur unique via une requête GET avec son ID.

    # 1. Préparation de la requête
    &{headers}=              Create Dictionary    Authorization=Bearer ${API_KEY}

    # 2. Exécution de la requête
    ${Reponse}=              GET    url=${Base_URL}api/users/${Id_Utilisateur}    headers=${headers}    expected_status=200

    # 3. Extraction et log du corps de la réponse JSON
    ${ReponseJson}=          Set Variable    ${Reponse.json()}
    Log                      ${ReponseJson}

    # 4. Vérifications des données
    Dictionary Should Contain Key    ${ReponseJson}    data
    Dictionary Should Contain Key    ${ReponseJson}    support

    ${Utilisateur}=          Get From Dictionary    ${ReponseJson}    data

    ${id}=                   Get From Dictionary    ${Utilisateur}    id
    Should Be Equal As Integers    ${id}    ${Id_Utilisateur}

    ${first_name}=           Get From Dictionary    ${Utilisateur}    first_name
    Should Be Equal As Strings    ${FirstName_Attendu}    ${first_name}

    ${last_name}=            Get From Dictionary    ${Utilisateur}    last_name
    Should Be Equal As Strings    ${LastName_Attendu}    ${last_name}

    ${email}=                Get From Dictionary    ${Utilisateur}    email
    Should Be Equal As Strings    ${Email_Attendu}    ${email}

    Dictionary Should Contain Key    ${Utilisateur}    avatar
