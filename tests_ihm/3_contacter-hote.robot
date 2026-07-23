*** Settings ***

Library    SeleniumLibrary
Resource    commun.resource
Test Setup    Ouvrir Le Navigateur Et Accéder A La Page De L Annonce
Suite Teardown    Close All Browsers


*** Test Cases ***

La Modale De Contact Doit S'afficher Après Un Clic Sur Le Bouton Contactez L'hôte
    Cliquer Sur Le Bouton Contactez L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible


La Modale De Contact Doit S'afficher Après Un Clic Sur Le Lien Contacter L'hôte
    Cliquer Sur Le Lien Contacter L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible


Tous Les Champs Et Le Bouton Soumettre Doivent Être Visibles Dans La Modale De Contact
    Cliquer Sur Le Bouton Contactez L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible
    Vérifier Que Le Formulaire De Contact Hôte Est Complet


Le Formulaire De Contact Doit Pouvoir Être Soumis Avec Des Informations Valides
    Cliquer Sur Le Bouton Contactez L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible
    Remplir Le Formulaire De Contact Hôte    Jean Dupont    jean.dupont@email.fr    0601020304    Bonjour, cette annonce est-elle toujours disponible aux dates du 15 au 20 juillet ?
    Soumettre Le Formulaire De Contact Hôte
    Vérifier Qu'un Message Est Affiché Après L'envoi Du Formulaire De Contact


La Modale De Contact Doit Se Fermer Après Un Clic Sur Le Bouton De Fermeture
    Cliquer Sur Le Bouton Contactez L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible
    Fermer La Modale De Contact Hôte
    Vérifier Que La Modale De Contact Hôte N'est Plus Visible


La Modale De Contact Hôte Ne Doit Pas Être Visible Avant Toute Interaction
    Vérifier Que La Modale De Contact Hôte N'est Plus Visible


Les Placeholders Des Champs Du Formulaire De Contact Doivent Être Corrects
    Cliquer Sur Le Bouton Contactez L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible
    Vérifier Que Les Placeholders Du Formulaire De Contact Hôte Sont Corrects


Les Informations Saisies Doivent Être Conservées Dans Les Champs Du Formulaire De Contact
    Cliquer Sur Le Bouton Contactez L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible
    Remplir Le Formulaire De Contact Hôte    Marie Martin    marie.martin@email.fr    0712345678    Est-ce que les animaux sont acceptés ?
    Vérifier Que Les Champs Du Formulaire De Contact Hôte Contiennent Les Valeurs Saisies    Marie Martin    marie.martin@email.fr    0712345678    Est-ce que les animaux sont acceptés ?


Le Formulaire De Contact Doit Pouvoir Être Soumis Avec Des Informations Valides Depuis Le Lien Contacter L'hôte
    Cliquer Sur Le Lien Contacter L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible
    Remplir Le Formulaire De Contact Hôte    Paul Bernard    paul.bernard@email.fr    0623456789    Bonjour, quelle est l'heure d'arrivée possible le jour de la réservation ?
    Soumettre Le Formulaire De Contact Hôte
    Vérifier Qu'un Message Est Affiché Après L'envoi Du Formulaire De Contact


Le Champ Email Doit Être De Type Email Et Le Champ Message Doit Comporter 5 Lignes
    Cliquer Sur Le Bouton Contactez L'hôte
    Vérifier Que La Modale De Contact Hôte Est Visible
    Vérifier Que Les Types Des Champs Du Formulaire De Contact Hôte Sont Corrects



