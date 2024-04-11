<?php


if (!function_exists('pcntl_fork'))
{
    die('PCNTL functions not available on this PHP installation');
}

$pid = pcntl_fork();

if ($pid == -1)
{

    die('Could not fork');
}
elseif ($pid)
{
    // РОдительский процесс
    echo "I'm the parent process.\n";
    pcntl_wait($status);
}
else
{
    // дочерний процесс
    echo "I'm the child process.\n";
    sleep(20);
}

echo "This is the end of the script.\n";