<?php
session_start();
require_once("include/fct.inc.php");
require_once ("modele/class.pdogsb.inc.php");
include("vues/v_entete.php") ;
$pdo = PdoGsb::getPdoGsb();
$estConnecteVisit = estConnecteVisit();
$estConnecteComptable = estConnecteCompt();
if(!isset($_REQUEST['uc'])){
    $uc = 'connexion';
}
else{
	$uc = trim(htmlentities($_REQUEST['uc']));
}	 
switch($uc){
	case 'connexion':{
		include("controleurs/c_connexion.php");break;
	}
	case 'gererFrais':{
		include("controleurs/c_gererFrais.php");break;
	}
	case 'etatFrais':{
		include("controleurs/c_etatFrais.php");break; 
	}
}

include("vues/v_pied.php") ;
?>

