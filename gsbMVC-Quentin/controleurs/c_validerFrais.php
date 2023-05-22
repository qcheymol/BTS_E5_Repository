<?php
// gestion du comptable
include("vues/v_sommaireComptable.php");
$idComptable = $_SESSION['cid'];
$mois = getMois(date('d/m/Y'));
$moisPrecedent = getMoisPrecedent($mois);
$action = trim(htmlentities($_REQUEST['action']));
switch($action)
{
	case'selectionnerVisiteur':{
        $lesVisiteurs=$pdo->getLesVisiteurs();
        $lesMois = getLesDouzeDerniersMois($mois);
			include("vues/v_listeVisiteur.php");
	break;
	}

	case'validerFicheVisiteur' :{
        $idVisiteur = $_POST['lstVisiteurs'];
		$lesVisiteurs = $pdo->getLesVisiteurs();
        $visiteurASelectionner=$idVisiteur;

		$leMois = $_POST['lstMois'];
		$lesMois = getLesDouzeDerniersMois($mois);
        $moisASelectionner=$leMois;

        $lesFraisForfait = $pdo->getLesFraisForfait($idVisiteur, $leMois);
        $lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idVisiteur, $leMois);
        $lesInfosFicheFrais = $pdo->getLesInfosFicheFrais($idVisiteur, $leMois);

		if(!is_array($lesInfosFicheFrais)){
            ajouterErreur('Pas de fiche de frais pour ce visiteur ce mois');
            include("vues/v_erreurs.php");
			include("vues/v_listeVisiteur.php");
		}
		else{
			$sommeHF = $pdo->montantHF($idVisiteur,$leMois);
			$totalHF=$sommeHF[0][0];
			$sommeFF=$pdo->montantFF($idVisiteur,$leMois);
			$totalFF=$sommeFF[0][0];
			$montantTotal=$totalHF+$totalFF;

			$nbJustificatifs = $lesInfosFicheFrais['nbJustificatifs'];
			
			include("vues/v_listeFrais.php");
		}
	break;
	}

	case'modifierFraisForfait' :{
        $idVisiteur = $_POST['lstVisiteurs'];
		$lesVisiteurs = $pdo->getLesVisiteurs();
        $visiteurASelectionner=$idVisiteur;

        $leMois = $_POST['lstMois'];
		$lesMois = getLesDouzeDerniersMois($mois);
        $moisASelectionner=$leMois;

		$lesFrais = $_POST['lesFrais'];
		if (lesQteFraisValides($lesFrais)) 
		{
            $pdo->majFraisForfait($idVisiteur, $leMois, $lesFrais);

            echo "La modification a bien été prise en compte.";
		} 
		else 
		{
            ajouterErreur('Les valeurs des frais doivent être numériques');
            include("vues/v_erreurs.php");
        }
			   
		$lesFraisForfait = $pdo->getLesFraisForfait($idVisiteur, $leMois);
		$lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idVisiteur, $leMois);
		$lesInfosFicheFrais = $pdo->getLesInfosFicheFrais($idVisiteur, $leMois);

		$sommeHF = $pdo->montantHF($idVisiteur,$leMois);
		$totalHF=$sommeHF[0][0];
		$sommeFF=$pdo->montantFF($idVisiteur,$leMois);
		$totalFF=$sommeFF[0][0];
		$montantTotal=$totalHF+$totalFF;

		$nbJustificatifs = $lesInfosFicheFrais['nbJustificatifs'];

		include("vues/v_listeFrais.php");
	break;
	}
	case'SupprimerFraisHorsForfait' :{
        $idVisiteur = trim(htmlentities($_GET['idVisiteur']));
		$lesVisiteurs = $pdo->getLesVisiteurs();
        $visiteurASelectionner=$idVisiteur;

		$leMois = trim(htmlentities($_GET['mois']));
		$lesMois = getLesDouzeDerniersMois($mois);
		$moisASelectionner=$leMois;
		
		$idFrais = trim(htmlentities($_GET['idFrais']));
		$pdo->supprimerFraisHorsForfait($idFrais);
		echo "La modification a bien été prise en compte.";

		$lesFraisForfait = $pdo->getLesFraisForfait($idVisiteur, $leMois);
		$lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idVisiteur, $leMois);
		$lesInfosFicheFrais = $pdo->getLesInfosFicheFrais($idVisiteur, $leMois);

		$sommeHF = $pdo->montantHF($idVisiteur,$leMois);
		$totalHF=$sommeHF[0][0];
		$sommeFF=$pdo->montantFF($idVisiteur,$leMois);
		$totalFF=$sommeFF[0][0];
		$montantTotal=$totalHF+$totalFF;

		$nbJustificatifs = $lesInfosFicheFrais['nbJustificatifs'];

		include("vues/v_listeFrais.php");
	break;
	}
	case'reporterFraisHorsForfait' :{
        $idVisiteur = trim(htmlentities($_GET['idVisiteur']));
		$lesVisiteurs = $pdo->getLesVisiteurs();
        $visiteurASelectionner=$idVisiteur;

		$leMois = trim(htmlentities($_GET['mois']));
		$lesMois = getLesDouzeDerniersMois($mois);
		$moisASelectionner=$leMois;
		
		$idFrais = trim(htmlentities($_GET['idFrais']));

		$libelleHF = trim(htmlentities($_GET['libelleHF']));
		$dateHF = trim(htmlentities($_GET['dateHF']));
		$montantHF = trim(htmlentities($_GET['montantHF']));

		$leMoisSuivant=getMoisSuivant($leMois);      
		if ($pdo->estPremierFraisMois($idVisiteur, $leMois)==true) {
			$pdo->creeNouvellesLignesFrais($idVisiteur, $leMois);
		}

		$pdo->reporterLigneHF($leMoisSuivant, $idFrais);

		$lesFraisForfait = $pdo->getLesFraisForfait($idVisiteur, $leMois);
		$lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idVisiteur, $leMois);
		$lesInfosFicheFrais = $pdo->getLesInfosFicheFrais($idVisiteur, $leMois);

		$sommeHF = $pdo->montantHF($idVisiteur,$leMois);
		$totalHF=$sommeHF[0][0];
		$sommeFF=$pdo->montantFF($idVisiteur,$leMois);
		$totalFF=$sommeFF[0][0];
		$montantTotal=$totalHF+$totalFF;

		$nbJustificatifs = $lesInfosFicheFrais['nbJustificatifs'];
		
		include("vues/v_listeFrais.php");
	break;
	}

	case 'validerFrais':{
        $idVisiteur = $_POST['lstVisiteurs'];
        $lesVisiteurs=$pdo->getLesVisiteurs();
        $visiteurASelectionner=$idVisiteur;
        $leMois = filter_input(INPUT_POST, 'lstMois', FILTER_SANITIZE_STRING);
        $lesMois = getLesDouzeDerniersMois($mois);
        $moisASelectionner=$leMois;
        $nbJustificatifs = filter_input(INPUT_POST, 'txtNbJustificatifs', FILTER_SANITIZE_STRING);
        $etat='VA';
        $pdo->majEtatFicheFrais($idVisiteur, $leMois, $etat);
        $pdo->majNbJustificatifs($idVisiteur, $leMois, $nbJustificatifs);
        $sommeHF=$pdo->montantHF($idVisiteur,$leMois);
        $totalHF=$sommeHF[0][0];
        $sommeFF=$pdo->montantFF($idVisiteur,$leMois);
        $totalFF=$sommeFF[0][0];
        $montantTotal=$totalHF+$totalFF;
		$pdo->total($idVisiteur,$leMois,$montantTotal);
		echo 'La fiche a bien été validée !';
        include("vues/v_accueil.php");
        break;

	}
}
?>