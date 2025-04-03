<?php

echo "Enter the N number: ";
$num = intval(trim(fgets(STDIN)));

if ($num < 1 || $num > 26) {
    echo "The N number must be from 1 to 26!" . PHP_EOL;
    return;
}

for ($i = 0; $i < $num; $i++) {
    for ($j = 0; $j <= $i; $j++) {
        echo chr($num - $j - 1 + ord('A')) . ' ';
    }
    echo PHP_EOL;
}

?>
