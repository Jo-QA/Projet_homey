# Exercice Final: Système de Gestion de Location Saisonnière Homey
# ================================================================
#
# Dans cet exercice, vous allez travailler avec un système simplifié de gestion 
# de propriétés de location saisonnière pour la plateforme Homey.
#
# Objectifs:
# 1. Étudiez l'implémentation de la classe HomeyManager
# 2. Complétez les tests unitaires dans la classe TestHomeyManager
# 3. Utilisez tous les types d'assertions que vous avez appris

class Propriete:
    """Représente une propriété de location saisonnière sur Homey."""
    
    def __init__(self, propriete_id, nom, prix_par_nuit):
        """Initialise une propriété avec ID, nom et prix."""
        self.propriete_id = propriete_id
        self.nom = nom
        self.prix_par_nuit = prix_par_nuit
        self.est_disponible = True
    
    def __str__(self):
        """Retourne une représentation textuelle de la propriété."""
        statut = "Disponible" if self.est_disponible else "Réservée"
        return f"Propriété {self.propriete_id}: '{self.nom}' - {self.prix_par_nuit}€/nuit - {statut}"


class HomeyManager:
    """Gère une collection de propriétés de location saisonnière sur Homey."""
    
    def __init__(self):
        """Initialise une collection de propriétés vide."""
        self.proprietes = []
    
    def ajouter_propriete(self, propriete_id, nom, prix_par_nuit):
        """
        Ajoute une nouvelle propriété à la collection.
        Lève ValueError si propriete_id existe déjà ou si le prix est négatif.
        """
        if prix_par_nuit <= 0:
            raise ValueError("Le prix par nuit doit être positif")
        
        # Vérifie si propriete_id existe déjà 
        for propriete in self.proprietes:
            if propriete.propriete_id == propriete_id:
                raise ValueError(f"Une propriété avec l'ID {propriete_id} existe déjà")
        
        # Crée et ajoute la nouvelle propriété
        nouvelle_propriete = Propriete(propriete_id, nom, prix_par_nuit)
        self.proprietes.append(nouvelle_propriete)
        return nouvelle_propriete
    
    def supprimer_propriete(self, propriete_id):
        """
        Supprime une propriété de la collection.
        Retourne True si réussi, False si la propriété n'a pas été trouvée.
        """
        for i, propriete in enumerate(self.proprietes):
            if propriete.propriete_id == propriete_id:
                del self.proprietes[i]
                return True
        return False
    
    def obtenir_propriete(self, propriete_id):
        """
        Obtient une propriété par son ID.
        Retourne la propriété si trouvée, None sinon.
        """
        for propriete in self.proprietes:
            if propriete.propriete_id == propriete_id:
                return propriete
        return None
    
    def rechercher_par_nom(self, nom_recherche):
        """
        Recherche des propriétés contenant le nom donné (insensible à la casse).
        Retourne une liste des propriétés correspondantes.
        """
        resultats = []
        for propriete in self.proprietes:
            if nom_recherche.lower() in propriete.nom.lower():
                resultats.append(propriete)
        return resultats
    
    def reserver_propriete(self, propriete_id):
        """
        Réserve une propriété (la marque comme indisponible).
        Retourne True si réussi, False si la propriété n'existe pas ou est déjà réservée.
        """
        propriete = self.obtenir_propriete(propriete_id)
        if propriete is None or not propriete.est_disponible:
            return False
        
        propriete.est_disponible = False
        return True
    
    def liberer_propriete(self, propriete_id):
        """
        Libère une propriété réservée (la marque comme disponible).
        Retourne True si réussi, False si la propriété n'existe pas ou est déjà libre.
        """
        propriete = self.obtenir_propriete(propriete_id)
        if propriete is None or propriete.est_disponible:
            return False
        
        propriete.est_disponible = True
        return True
    
    def obtenir_proprietes_disponibles(self):
        """Retourne une liste de toutes les propriétés disponibles."""
        return [propriete for propriete in self.proprietes if propriete.est_disponible]
    
    def obtenir_proprietes_reservees(self):
        """Retourne une liste de toutes les propriétés réservées."""
        return [propriete for propriete in self.proprietes if not propriete.est_disponible] 