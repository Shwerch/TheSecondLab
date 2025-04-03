<?php

echo "Enter the string of numbers with ' ' separator: ";
$input = trim(fgets(STDIN));

$separators = [-1];
$length = strlen($input);

// Find the positions of the separators (spaces)
for ($i = 0; $i < $length; $i++) {
    if ($input[$i] === ' ') {
        $separators[] = $i;
    }
}
$separators[] = $length;

// Create a 2D array to hold the numbers
$numbers = [];
for ($i = 0; $i < count($separators) - 1; $i++) {
    $j = $i + 1;
    $numbers[$i] = [];
    for ($k = $separators[$i] + 1; $k < $separators[$j]; $k++) {
        $numbers[$i][] = $input[$k];
    }
}

// Prepare the answer array
$answer = [];
for ($i = 0; $i < count($numbers); $i++) {
    $summ = 0;
    $multi = 1;
    foreach ($numbers[$i] as $j) {
        $num = intval($j);
        if ($num < 0 || $num > 9) {
            echo "You should have entered the numbers!" . PHP_EOL;
            exit(1);
        }
        $summ += $num;
        $multi *= $num;
    }
    if ($summ < $multi) {
        $answer[] = $i;
    }
}

// Output the answer
foreach ($answer as $i) {
    echo $i . " ";
}
echo PHP_EOL;

?>
