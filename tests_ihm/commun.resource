*** Settings ***
Library    SeleniumLibrary
# j'ai changé library selenium2library par seleniumlibrary car la première est obsolète

*** Variables ***

${URL}                     http://livraison3.testacademy.fr/
${NAVIGATEUR}              Firefox
${LIEN CONNEXION}          xpath=//a[contains(text(),'Se connecter')]
${LIEN DECONNEXION}        xpath=(//a[contains(text(),'Se déconnecter')])[3]
${BOUTON CONNEXION}        css=.homey_login_button
${CHAMP NOM UTILISATEUR}   xpath=//input[@name='username']
${CHAMP MOT DE PASSE}      xpath=//input[@name='password']
${UTILISATEUR}             robot
${MOT DE PASSE}            robot
${TITRE TABLEAU DE BORD}   Tableau de bord - Livraison 3
${MESSAGE D'ERREUR}        css=#modal-login .error

# --- Contacter l'hôte ---
${URL FICHE ANNONCE}                       http://livraison3.testacademy.fr/index.php/listing/large-and-modern-bedroom/
${LIEN CONTACTER HOTE}                     css=a[data-target='#modal-contact-host']
${BOUTON CONTACTER HOTE}                   css=button[data-target='#modal-contact-host']
${MODALE CONTACT HOTE}                     css=#modal-contact-host
${TITRE MODALE CONTACT HOTE}               css=#modal-contact-host .modal-title
${BOUTON FERMETURE MODALE CONTACT HOTE}    css=#modal-contact-host .close
${CHAMP NOM CONTACT}                       css=#modal-contact-host input[name='name']
${CHAMP EMAIL CONTACT}                     css=#modal-contact-host input[name='email']
${CHAMP TELEPHONE CONTACT}                 css=#modal-contact-host input[name='phone']
${CHAMP MESSAGE CONTACT}                   css=#modal-contact-host textarea[name='message']
${BOUTON SOUMETTRE CONTACT}                css=#modal-contact-host .contact_listing_host
${ZONE MESSAGES CONTACT}                   css=#modal-contact-host .homey_contact_messages


*** Keywords ***

Vérifier Que Le Message D'erreur Est Visible
    Wait Until Element Is Visible   ${MESSAGE D'ERREUR}

Ouvrir Le Navigateur Et Accéder A L'Application
    Open Browser    ${URL}    ${NAVIGATEUR}
    Maximize Browser Window

Accéder A La Page De Connexion
    Click Element    ${LIEN CONNEXION}

Saisir Les Identifiants De Connexion
    [Arguments]    ${utilisateur}   ${mot_de_passe}
    Wait Until Element Is Visible    ${CHAMP NOM UTILISATEUR}
    Click Element    ${CHAMP NOM UTILISATEUR}
    Input Text    ${CHAMP NOM UTILISATEUR}    ${utilisateur}
    Click Element    ${CHAMP MOT DE PASSE}
    Input Text    ${CHAMP MOT DE PASSE}    ${mot_de_passe}

Soumettre Le Formulaire De Connexion
    Click Button    ${BOUTON CONNEXION}

Vérifier Que Le Tableau De Bord Est Visible
    Wait Until Element Is Not Visible    ${CHAMP NOM UTILISATEUR}
    Title Should Be    ${TITRE TABLEAU DE BORD}

Effectuer Une Connexion Réussie
    Ouvrir Le Navigateur Et Accéder A L'Application
    Accéder A La Page De Connexion
    Saisir Les Identifiants De Connexion    robot    robot
    Soumettre Le Formulaire De Connexion

Effectuer Une Déconnexion Réussie
    Wait Until Element Is Visible    ${LIEN DECONNEXION}
    Click Element   ${LIEN DECONNEXION}
    Wait Until Element Is Not Visible    ${LIEN DECONNEXION}

Vérifier Que Le Lien De Connexion Est Visible
    Wait Until Element Is Visible   ${LIEN CONNEXION}

# --- Contacter l'hôte ---
Ouvrir Le Navigateur Et Accéder A La Page De L Annonce
    Open Browser    ${URL FICHE ANNONCE}    ${NAVIGATEUR}
    Maximize Browser Window

Cliquer Sur Le Bouton Contactez L'hôte
    Wait Until Element Is Visible    ${BOUTON CONTACTER HOTE}
    Click Element    ${BOUTON CONTACTER HOTE}

Cliquer Sur Le Lien Contacter L'hôte
    Wait Until Element Is Visible    ${LIEN CONTACTER HOTE}
    Click Element    ${LIEN CONTACTER HOTE}

Vérifier Que La Modale De Contact Hôte Est Visible
    Wait Until Element Is Visible    ${MODALE CONTACT HOTE}
    Element Should Contain    ${TITRE MODALE CONTACT HOTE}    Contactez l'hôte

Vérifier Que La Modale De Contact Hôte N'est Plus Visible
    Wait Until Element Is Not Visible    ${MODALE CONTACT HOTE}

Vérifier Que Le Formulaire De Contact Hôte Est Complet
    Element Should Be Visible    ${CHAMP NOM CONTACT}
    Element Should Be Visible    ${CHAMP EMAIL CONTACT}
    Element Should Be Visible    ${CHAMP TELEPHONE CONTACT}
    Element Should Be Visible    ${CHAMP MESSAGE CONTACT}
    Element Should Be Visible    ${BOUTON SOUMETTRE CONTACT}

Remplir Le Formulaire De Contact Hôte
    [Arguments]    ${nom}    ${email}    ${telephone}    ${message}
    Click Element    ${CHAMP NOM CONTACT}
    Input Text    ${CHAMP NOM CONTACT}    ${nom}
    Click Element    ${CHAMP EMAIL CONTACT}
    Input Text    ${CHAMP EMAIL CONTACT}    ${email}
    Click Element    ${CHAMP TELEPHONE CONTACT}
    Input Text    ${CHAMP TELEPHONE CONTACT}    ${telephone}
    Click Element    ${CHAMP MESSAGE CONTACT}
    Input Text    ${CHAMP MESSAGE CONTACT}    ${message}

Soumettre Le Formulaire De Contact Hôte
    Click Button    ${BOUTON SOUMETTRE CONTACT}

Vérifier Qu'un Message Est Affiché Après L'envoi Du Formulaire De Contact
    Wait Until Element Is Visible    ${ZONE MESSAGES CONTACT}

Fermer La Modale De Contact Hôte
    Wait Until Element Is Visible    ${BOUTON FERMETURE MODALE CONTACT HOTE}
    Click Element    ${BOUTON FERMETURE MODALE CONTACT HOTE}

Vérifier Que Les Placeholders Du Formulaire De Contact Hôte Sont Corrects
    Element Attribute Value Should Be    ${CHAMP NOM CONTACT}    placeholder    Nom
    Element Attribute Value Should Be    ${CHAMP EMAIL CONTACT}    placeholder    Email
    Element Attribute Value Should Be    ${CHAMP TELEPHONE CONTACT}    placeholder    Téléphone
    Element Attribute Value Should Be    ${CHAMP MESSAGE CONTACT}    placeholder    Message

Vérifier Que Les Champs Du Formulaire De Contact Hôte Contiennent Les Valeurs Saisies
    [Arguments]    ${nom}    ${email}    ${telephone}    ${message}
    Textfield Value Should Be    ${CHAMP NOM CONTACT}    ${nom}
    Textfield Value Should Be    ${CHAMP EMAIL CONTACT}    ${email}
    Textfield Value Should Be    ${CHAMP TELEPHONE CONTACT}    ${telephone}
    Textarea Value Should Be    ${CHAMP MESSAGE CONTACT}    ${message}

Vérifier Que Les Types Des Champs Du Formulaire De Contact Hôte Sont Corrects
    Element Attribute Value Should Be    ${CHAMP NOM CONTACT}    type    text
    Element Attribute Value Should Be    ${CHAMP EMAIL CONTACT}    type    email
    Element Attribute Value Should Be    ${CHAMP TELEPHONE CONTACT}    type    text
    Element Attribute Value Should Be    ${CHAMP MESSAGE CONTACT}    rows    5
