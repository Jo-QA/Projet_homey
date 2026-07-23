*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary        # Import de la bibliothèque pour la manipulation JSON
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}    https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}     Cle-API-ReqRes-test-academy            # Clé API pour l'authentification

*** Test Cases ***
Test 001 Requete GET
    [Documentation]    Vérifie la récupération de la liste des utilisateurs via une requête GET.
    
    # 1. Préparation de la requête
    &{Params}=               Create Dictionary    page=1    per_page=6
    &{headers}=              Create Dictionary    Authorization=Bearer ${API_KEY}
    
    # 2. Exécution de la requête
    ${Reponse}=              GET    url=${Base_URL}api/users    params=${Params}    headers=${headers}    expected_status=200
    
    # 3. Extraction et log du corps de la réponse JSON
    ${ReponseJson}=          Set Variable    ${Reponse.json()}
    Log                      ${ReponseJson}
    
    # 4. Vérifications des données
    ${ListeUtilisateurs}=    Get Value From Json    ${ReponseJson}    data[:]
    ${PremierUtilisateur}=   Get From List          ${ListeUtilisateurs}    0
    Should Be Equal          ${PremierUtilisateur['first_name']}    George
