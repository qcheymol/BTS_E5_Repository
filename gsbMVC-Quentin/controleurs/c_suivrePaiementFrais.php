<?php
// gestion du comptable
include("vues/v_sommaireComptable.php");

$mois = getMois(date('d/m/Y'));
$idComptable = $_SESSION['cid'];
$action = trim(htmlentities($_REQUEST['action']));
switch($action)
{
	case'selectionnerVisiteur':{
        $lesVisiteurs = $pdo->getLesVisiteursDontFicheVA();
		include("vues/v_listeVisiteurRembourse.php");

	break;
	}
	case'validerVisiteur' :{
        $idVisiteur = $idVisiteur = $_POST['lstVisiteurs'];
        $lesMois = $pdo->getLesMoisDontFicheVA();
		include("vues/v_listeMoisRembourse.php");
	break;
	}
	case'validerMois' :{
        $idVisiteur = $idVisiteur = $_POST['lstVisiteurs'];

		$leMois = $_POST['lstMois'];
		$lesMois=$pdo->getLesMoisDisponiblesDontFicheVA($idVisiteur);
		$moisASelectionner = $leMois;
		
        $lesFraisForfait = $pdo->getLesFraisForfait($idVisiteur, $leMois);
        $lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idVisiteur, $leMois);
		$lesInfosFicheFrais = $pdo->getLesInfosFicheFrais($idVisiteur, $leMois);
		
		$sommeHF = $pdo->montantHF($idVisiteur,$leMois);
		$totalHF=$sommeHF[0][0];
		$sommeFF=$pdo->montantFF($idVisiteur,$leMois);
		$totalFF=$sommeFF[0][0];
		$montantTotal=$totalHF+$totalFF;

		$numMois = substr($leMois,4);
		$numAnnee = substr($leMois,0, -2);

		$nbJustificatifs = $lesInfosFicheFrais['nbJustificatifs'];
		$libEtat = $lesInfosFicheFrais['libEtat'];
		$montantValide = $lesInfosFicheFrais['montantValide'];
		$nbJustificatifs = $lesInfosFicheFrais['nbJustificatifs'];
		$dateModif =  $lesInfosFicheFrais['dateModif'];
		$dateModif =  dateAnglaisVersFrancais($dateModif);

		include("vues/v_listeMoisRembourse.php");

		include("vues/v_listeFraisRembourse.php");
	break;
	}
	case'validerRemboursement' :{
        $idVisiteur = $_GET['idVisiteur'];
		$lesVisiteurs=$pdo->getLesVisiteurs();
        $visiteurASelectionner=$idVisiteur; 
		
		$leMois = $_GET['leMois'];
        $lesMois = $pdo->getLesMoisDisponibles($idVisiteur);
		$moisASelectionner = $leMois;

        $etat='RB';
		$pdo->majEtatFicheFrais($idVisiteur, $leMois, $etat);
		
		echo 'La fiche a bien été remboursée !';
		include("vues/v_accueil.php");
	break;
	}
}

?>