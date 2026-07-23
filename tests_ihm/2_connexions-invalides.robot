*** Settings ***

Library    SeleniumLibrary
Resource    commun.resource
Test Template    Un Message D'erreur Devrait Etre Visible Après Une Connexion Echouée
Test Setup    Ouvrir Le Navigateur Et Accéder A L'Application
Suite Teardown    Close All Browsers


*** Test Cases ***

#cas de test                              #nom d'utilisateur        #mot de passe
Test 1 - ID OK / MDP NOK                  robot                     azerty
Test 2 - ID NOK / MDP NOK                 azerty                    azerty
Test 3 - ID NOK / MDP OK                  azerty                    robot
Test 4 - ID vide / MDP NOK                ${EMPTY}                  azerty     
Test 5 - ID vide / MDP OK                 ${EMPTY}                  robot
Test 6 - ID OK / MDP vide                 robot                     ${EMPTY}
Test 7 - ID NOK / MDP vide                azerty                    ${EMPTY}



*** Keywords ***

Un Message D'erreur Devrait Etre Visible Après Une Connexion Echouée
    [Arguments]    ${utilisateur}    ${mot_de_passe}
    Accéder A La Page De Connexion
    Saisir Les Identifiants De Connexion    ${utilisateur}    ${mot_de_passe}
    Soumettre Le Formulaire De Connexion
    Vérifier Que Le Message D'erreur Est Visible