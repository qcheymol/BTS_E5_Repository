    <!-- Division pour le sommaire -->
    <div id="menuGauche">
     <div id="infosUtil">
    
        <h2>
		<?php  
			echo $_SESSION['prenom']."  ".$_SESSION['nom'];
		?>   
		</h2>
         <h3>comptable</h3>    
      </div>  
        <ul id="menuList">
			<li class="smenu">
              <a href="index.php?uc=connexion&action=deconnexion" title="Se déconnecter">Déconnexion</a>
			</li>
         </ul>
        
    </div>