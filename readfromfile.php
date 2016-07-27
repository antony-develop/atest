<?php
header('Content-Type: text/html; charset=utf-8');
require_once 'db_connect.php';

//читаем риестры из директории

//получаем имена файлов в директории
$files = glob("./txt/*.txt");

if ($files){
    
    echo "true";
}
 else {
     echo "false";
}

//данные, которые необходимо записать в таблицу
$searchFor = array(
"start_order" => "ДатаНачала",
"end_order" => "ДатаКонца",
"document_id" => "Номер",
"amount" => "Сумма",
"payer" => "ПлательщикСчет",
"payer_bank" => "ПлательщикБанк1",
"payee" => "ПолучательСчет",
"payment_name" => "НазначениеПлатежа",
);

$dataForTable = array();
foreach ($files as $fileName) {

    // get the file contents
    $contents = file_get_contents($fileName);
//    $contents = mb_convert_encoding($contents, "utf-8", "Windows-1251, ANSI");

    foreach ($searchFor as $fildName => $name){
        // escape special characters in the query
        $pattern = preg_quote($name, '/');
        // finalise the regular expression, matching the whole line
        $pattern = "/^.*$pattern.*\$/m";
        // search, and store all matching occurences in $matches
        if(preg_match_all($pattern, $contents, $matches)){
           list($name,$value)=explode("=",$matches[0][0]);
           $dataForTable[$fildName] = $value;
        }
        else{
           echo "No matches found";
        }
    }

    echo "<pre>";
    print_r($dataForTable);
    echo "</pre>";
    
    

        //Записываем данные из реестров в бд
    $statement = $db->prepare("INSERT INTO registries "
            . "(start_order, end_order, document_id, "
            . "amount, payer, payer_bank, payee, payment_name) "
            . "VALUES"
            . "(:start_order, :end_order, :document_id, :amount, "
            . ":payer, :payer_bank, :payee, :payment_name)"); 

    $statement->execute(array(
                "start_order" => date("Y-m-d H:i:s", strtotime($dataForTable[start_order])),
                "end_order" => date("Y-m-d H:i:s", strtotime($dataForTable[end_order])),
                "document_id" => "$dataForTable[document_id]",
                "amount" => "$dataForTable[amount]",
                "payer" => "$dataForTable[payer]",
                "payer_bank" => "$dataForTable[payer_bank]",
                "payee" => "$dataForTable[payee]",
                "payment_name" => "$dataForTable[payment_name]"

            ));   
}

//получаем реестры из бд
$result = $db->query('SELECT * '
                    . 'FROM registries '
                    . 'ORDER BY id');

$registre = array(); 

$i=0;
while ($row = $result->fetch()){
    $registre[$i]['id'] = $row['id'];
    $registre[$i]['start_order'] = $row['start_order'];
    $registre[$i]['end_order'] = $row['end_order'];
    $registre[$i]['document_id'] = $row['document_id'];
    $registre[$i]['amount'] = $row['amount'];
    $registre[$i]['payer'] = $row['payer'];
    $registre[$i]['payer_bank'] = $row['payer_bank'];
    $registre[$i]['payee'] = $row['payee'];
    $registre[$i]['payment_name'] = $row['payment_name'];
    $i++;            
} 
        
echo "<pre>";
print_r($registre);
echo "</pre>";
?>