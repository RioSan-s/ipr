<?php

$options = array(
    'location' => 'http://localhost:8015/server.php',
    'uri' => 'http://localhost:8015',
    'trace' => 1,
);

$client = new SoapClient('calculator2.wsdl', $options);

$a = 5;
$b = 3;

try {
    $result = $client->__soapCall('add',[$a, $b]);
    echo "Result of adding $a and $b: $result\n";
} catch (SoapFault $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>