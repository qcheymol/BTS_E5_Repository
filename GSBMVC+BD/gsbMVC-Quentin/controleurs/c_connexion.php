<?php
if(!isset($_REQUEST['action'])){
	$action = 'demandeConnexion';
}else{
	$action = trim(htmlentities($_REQUEST['action']));
}

switch($action){
	case 'demandeConnexion':{
		include("vues/v_connexion.php");
		break;
	}
	case 'valideConnexion':{
		$login = trim(htmlentities($_REQUEST['login']));
		$mdp = trim(htmlentities($_REQUEST['mdp']));
		$visiteur = $pdo->getInfosVisiteur($login,$mdp);
		$comptable = $pdo->getInfosComptable($login,$mdp);
		if(!is_array($visiteur)){
			if(!is_array($comptable)){
				ajouterErreur("Login ou mot de passe incorrect");
				include("vues/v_erreurs.php");
				include("vues/v_connexion.php");
			}
			else{
				//comptable connecté
				$id = $comptable['id'];
				$nom =  $comptable['nom'];
				$prenom = $comptable['prenom'];
				connecterCompt($id,$nom,$prenom);
				include("vues/v_sommaire.php");
				include("vues/v_accueil.php");
			}
		}else{
			//Visiteur connecté
			$id = $visiteur['id'];
			$nom =  $visiteur['nom'];
			$prenom = $visiteur['prenom'];
			connecterVisit($id,$nom,$prenom);
			include("vues/v_sommaire.php");
			include("vues/v_accueil.php");
		}	
		break;		
	}
	case 'deconnecter':{
		deconnecter();
		include("vues/v_connexion.php");
		break;
	}	
	default :{
		include("vues/v_connexion.php");
		break;
	}
}
?>