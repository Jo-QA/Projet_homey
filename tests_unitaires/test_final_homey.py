# Tests unitaires pour le système de gestion Homey - A compléter par les étudiants

import unittest
from final_homey import HomeyManager, Propriete

class TestHomeyManager(unittest.TestCase):
    """
    Classe de tests unitaires pour le système de gestion Homey.
    
    TODO: Complétez les tests en utilisant toutes les assertions apprises :
    - assertEqual, assertTrue, assertFalse  
    - assertIsNone, assertIsNotNone
    - assertIn, assertNotIn
    - assertRaises
    """
    
    def setUp(self):
        """Prépare un HomeyManager et quelques propriétés de test avant chaque test."""
        # TODO: Initialiser self.manager et ajouter quelques propriétés de test
        self.manager = HomeyManager()
        self.p1 = self.manager.ajouter_propriete(1, "Maison", 150)
        self.p2 = self.manager.ajouter_propriete(2, "Appartement", 100)
        self.p3 = self.manager.ajouter_propriete(3, "Villa", 300)
    
    # TODO: Tests pour ajouter_propriete()
    # 1. Test ajout propriété valide (assertEqual)
    def test_ajouter_propriete_valide(self):
        self.manager.ajouter_propriete(4, "Chalet", 200)
        self.assertEqual(len(self.manager.proprietes), 4)
    
    # 2. Test ajout propriété avec ID en double (assertRaises)
    def test_ajouter_propriete_id_double(self):
        with self.assertRaises(ValueError):
            self.manager.ajouter_propriete(1, "Maison", 150)

    # 3. Test ajout propriété avec prix négatif (assertRaises)
    def test_ajouter_propriete_prix_negatif(self):
        with self.assertRaises(ValueError):
            self.manager.ajouter_propriete(4, "Chalet", -200)
            
    # TODO: Tests pour supprimer_propriete()
    # 4. Test suppression propriété existante (assertTrue)
    def test_supprimer_propriete_existante(self):
        self.assertTrue(self.manager.supprimer_propriete(1))
    # 5. Test suppression propriété inexistante (assertFalse)
    def test_supprimer_propriete_inexistante(self):
        self.assertFalse(self.manager.supprimer_propriete(4))
    
    # TODO: Tests pour obtenir_propriete()
    # 6. Test obtention propriété existante (assertIsNotNone)
    def test_obtenir_propriete_existante(self):
        self.assertIsNotNone(self.manager.obtenir_propriete(1))

    # 7. Test obtention propriété inexistante (assertIsNone)
    def test_obtenir_propriete_inexistante(self):
        self.assertIsNone(self.manager.obtenir_propriete(4))
    
    # TODO: Tests pour rechercher_par_nom()
    # 8. Test recherche nom existant (assertIn)
    def test_rechercher_par_nom_existant(self):
        self.assertIn(self.p1, self.manager.rechercher_par_nom("Maison"))
        
    # 9. Test recherche nom inexistant (liste vide)
    def test_rechercher_par_nom_inexistant(self):
        self.assertEqual(self.manager.rechercher_par_nom("Chalet"), [])
    
    # TODO: Tests pour reserver_propriete()
    # 10. Test réservation valide (assertTrue)
    def test_reserver_propriete_valide(self):
        self.assertTrue(self.manager.reserver_propriete(1))
            
    # 11. Test réservation propriété inexistante (assertFalse)
    def test_reserver_propriete_inexistante(self):
        self.assertFalse(self.manager.reserver_propriete(4))
        
    # 12. Test réservation propriété déjà réservée (assertFalse)
    def test_reserver_propriete_deja_reservee(self):
        self.manager.reserver_propriete(1)
        self.assertFalse(self.manager.reserver_propriete(1))
    
    # TODO: Tests pour les listes de propriétés
    # 13. Test obtenir propriétés disponibles (assertIn/assertNotIn)
    def test_obtenir_proprietes_disponibles(self):
        self.assertIn(self.p1, self.manager.obtenir_proprietes_disponibles())
    
    # 14. Test obtenir propriétés réservées (assertIn/assertNotIn)
    def test_obtenir_proprietes_reservees(self):
        self.manager.reserver_propriete(1)
        self.assertIn(self.p1, self.manager.obtenir_proprietes_reservees())

    # Tests pour liberer propriete
    def test_liberer_propriete_valide(self):
        self.manager.reserver_propriete(1)
        self.assertTrue(self.manager.liberer_propriete(1))

    def test_liberer_propriete_inexistante(self):
        self.assertFalse(self.manager.liberer_propriete(4))

    def test_liberer_propriete_deja_libre(self):
        self.assertFalse(self.manager.liberer_propriete(1))

    # Test de la représentation textuelle 
    def test_propriete_str(self):
        self.assertEqual(str(self.p1), "Propriété 1: 'Maison' - 150€/nuit - Disponible")
        self.manager.reserver_propriete(1)
        self.assertEqual(str(self.p1), "Propriété 1: 'Maison' - 150€/nuit - Réservée")


if __name__ == "__main__":
    unittest.main() 