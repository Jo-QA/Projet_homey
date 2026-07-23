*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary        # Import de la bibliothèque pour la manipulation JSON
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}         https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}          Cle-API-ReqRes-test-academy            # Clé API pour l'authentification
${Id_Ressource}     2                                      # ID de la ressource à récupérer

*** Test Cases ***
Test 006 Requete GET Liste Ressources
    [Documentation]    Vérifie la récupération de la liste paginée des ressources via une requête GET sur /api/unknown.

    # 1. Préparation de la requête
    &{Params}=               Create Dictionary    page=1    per_page=6
    &{headers}=              Create Dictionary    Authorization=Bearer ${API_KEY}

    # 2. Exécution de la requête
    ${Reponse}=              GET    url=${Base_URL}api/unknown    params=${Params}    headers=${headers}    expected_status=200

    # 3. Extraction et log du corps de la réponse JSON
    ${ReponseJson}=          Set Variable    ${Reponse.json()}
    Log                      ${ReponseJson}

    # 4. Vérifications de la structure de pagination
    Dictionary Should Contain Key    ${ReponseJson}    page
    Dictionary Should Contain Key    ${ReponseJson}    per_page
    Dictionary Should Contain Key    ${ReponseJson}    total
    Dictionary Should Contain Key    ${ReponseJson}    total_pages
    Dictionary Should Contain Key    ${ReponseJson}    data
    Dictionary Should Contain Key    ${ReponseJson}    support

    ${page}=                 Get From Dictionary    ${ReponseJson}    page
    Should Be Equal As Integers    ${page}    1

    # 5. Vérifications des données de la première ressource
    ${ListeRessources}=      Get Value From Json    ${ReponseJson}    data[:]
    ${PremiereRessource}=    Get From List    ${ListeRessources}    0

    Dictionary Should Contain Key    ${PremiereRessource}    id
    Dictionary Should Contain Key    ${PremiereRessource}    name
    Dictionary Should Contain Key    ${PremiereRessource}    year
    Dictionary Should Contain Key    ${PremiereRessource}    color
    Dictionary Should Contain Key    ${PremiereRessource}    pantone_value

Test 007 Requete GET Ressource Unique
    [Documentation]    Vérifie la récupération d'une ressource unique via une requête GET avec son ID sur /api/unknown/{resource_id}.

    # 1. Préparation de la requête
    &{headers}=              Create Dictionary    Authorization=Bearer ${API_KEY}

    # 2. Exécution de la requête
    ${Reponse}=              GET    url=${Base_URL}api/unknown/${Id_Ressource}    headers=${headers}    expected_status=200

    # 3. Extraction et log du corps de la réponse JSON
    ${ReponseJson}=          Set Variable    ${Reponse.json()}
    Log                      ${ReponseJson}

    # 4. Vérifications de la structure de la réponse
    Dictionary Should Contain Key    ${ReponseJson}    data
    Dictionary Should Contain Key    ${ReponseJson}    support

    ${Ressource}=            Get From Dictionary    ${ReponseJson}    data

    # 5. Vérifications des champs de la ressource
    Dictionary Should Contain Key    ${Ressource}    id
    Dictionary Should Contain Key    ${Ressource}    name
    Dictionary Should Contain Key    ${Ressource}    year
    Dictionary Should Contain Key    ${Ressource}    color
    Dictionary Should Contain Key    ${Ressource}    pantone_value

    ${id}=                   Get From Dictionary    ${Ressource}    id
    Should Be Equal As Integers    ${id}    ${Id_Ressource}
