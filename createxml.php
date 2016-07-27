<?php
header('Content-Type: text/html; charset=utf-8');
require_once 'db_connect.php';

$result = $db->query('SELECT '
            . 'p.delivery_type, p.doc_date, p.doc_date, p.form_revision, '
            . 'p.operation_type, p.queue, p.payment_info, p.amount, p.currency, '
            . ''
            . 'ps.type, ps.inn as payer_inn, ps.kpp as payer_kpp, ps.name as payer_name, ps.number as payer_number, '
            . ''
            . 'b.account_namber as payer_bank_account_number, b.bic as payer_bank_bic, b.name as payer_bank_name, b.city as payer_bank_city, '
            . ''
            . 'ps2.type, ps2.inn as payee_inn, ps2.kpp as payee_kpp, ps2.name as payee_name, ps2.number as payee_number, '
            . ''
            . 'b2.account_namber as payee_bank_account_number, b2.bic as payee_bank_bic, b2.name as payee_bank_name, b2.city as payee_bank_city '
        . 'FROM payments p '
        . 'LEFT JOIN payment_sides ps '
            . 'ON ps.payment_id = p.id '
        . 'LEFT JOIN payment_sides ps2 '
            . 'ON ps2.payment_id = p.id '
        . 'LEFT JOIN banks b '
            . 'ON b.payment_side_id = ps.id '
        . 'LEFT JOIN banks b2 '
            . 'ON b2.payment_side_id = ps2.id '
        . 'WHERE ps.type =  "payer" '
        . 'AND ps2.type = "payee"')
        or die("Error! Unable to get data from db");

$i=0;
while ($row = $result->fetch()){

//    echo "<pre>";
//    print_r($row);
    
$xml = new SimpleXMLElement('<payment/>');
$xml->addAttribute('delivery_type', $row['delivery_type']);
$xml->addAttribute('doc_date', $row['doc_date']);
$xml->addAttribute('document_type', $row['document_type']);
$xml->addAttribute('doc_number', $row['doc_number']);
$xml->addAttribute('form_revision', $row['form_revision']);
$xml->addAttribute('operation_type', $row['operation_type']);
$xml->addAttribute('queue', $row['queue']);

$amount = $xml->addChild('amount');
$amount->addAttribute('currency', $row['currency']);
$amount->addAttribute('value', $row['amount']);

$xml->addChild('payment-info', $row['payment_info']);

$payer = $xml->addChild('payer');
$payer->addAttribute('inn', $row['payer_inn']);
$payer->addAttribute('kpp', $row['payer_kpp']);
$payer->addAttribute('name', $row['payer_name']);

    $account = $payer->addChild('account');
    $account->addAttribute('number', $row['payer_number']);

        $bank = $account->addChild('bank');
        $bank->addAttribute('account-number', $row['payer_bank_account_namber']);
        $bank->addAttribute('bic', $row['payer_bank_bic']);
        $bank->addAttribute('name', $row['payer_bank_name']);

            $adress = $bank->addChild('address');
            $adress->addAttribute('city', $row['payer_bank_city']);
            
            
$payee = $xml->addChild('payee');
$payee->addAttribute('inn', $row['payee_inn']);
$payee->addAttribute('kpp', $row['payee_kpp']);
$payee->addAttribute('name', $row['payee_name']);

    $account = $payee->addChild('account');
    $account->addAttribute('number', $row['payee_number']);

        $bank = $account->addChild('bank');
        $bank->addAttribute('account-number', $row['payee_bank_account_namber']);
        $bank->addAttribute('bic', $row['payee_bank_bic']);
        $bank->addAttribute('name', $row['payee_bank_name']);

            $adress = $bank->addChild('address');
            $adress->addAttribute('city', $row['payee_bank_city']);
            
if($xml->saveXML('xml/testxml_'.$i.'.xml'))
{
    echo "File 'testxml_".$i.".xml' was created in /xml/ directory<br>";
}
$i++;
}            
//Header('Content-type: text/xml');
//echo $xml->asXML();





























