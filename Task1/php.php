<?php
echo "Enter the N number: ";
$num = intval(fgets(STDIN));

for ($i = 1; $i <= $num; $i++) {
    for ($j = 1; $j <= $i; $j++) {
        echo chr($num - $j + ord('A')) . " ";
    }
    echo PHP_EOL;
}