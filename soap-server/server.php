<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

class Calculator
{
    /**
     * @param int $a
     * @param int $b
     *
     * @return int
     */
    public function add(int $a, int $b):int
    {
        return $a+$b;
    }
}
$options = ['uri' => 'http://localhost:8015'];
$server  = new SoapServer('calculator2.wsdl', $options);
$server->setClass('Calculator');
$server->handle();
