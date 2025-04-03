<?php

echo "Enter the string of numbers with ' ' separator: ";
$input = trim(fgets(STDIN));

$separators = [-1];
for ($i = 0; $i < strlen($input); $i++) {
    if ($input[$i] === ' ') {
        $separators[] = $i;
    }
}
$separators[] = strlen($input);

$numbers = [];
for ($i = 0; $i < count($separators) - 1; $i++) {
    $numbers[] = [];
    for ($k = $separators[$i] + 1; $k < $separators[$i + 1]; $k++) {
        $numbers[$i][] = $input[$k];
    }
}

$answer = [];
for ($i = 0; $i < count($numbers); $i++) {
    $summ = 0;
    $multi = 1;
    foreach ($numbers[$i] as $j) {
        $num = ord($j) - ord('0');
        if ($num < 0 || $num > 9) {
            echo "You should have entered the numbers!\n";
            return;
        }
        $summ += $num;
        $multi *= $num;
    }
    if ($summ < $multi) {
        $answer[] = $i;
    }
}

echo implode(" ", $answer);
if (count($answer) > 0) echo "\n";

?>
