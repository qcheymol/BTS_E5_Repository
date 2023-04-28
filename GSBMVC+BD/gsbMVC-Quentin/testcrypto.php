<?php
$pass='mot de passe';
$hash=password_hash($pass, PASSWORD_DEFAULT);
echo $hash.'<br>';

if(password_get_info($pass,$hash)){
    echo "reussi";
}
else{
    echo"mauvais";
}
