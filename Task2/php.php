<?php

echo "Enter the string of numbers with ',' separator: ";
$input = trim(fgets(STDIN));

$separators = [-1];
for ($i = 0; $i < strlen($input); $i++) {
    if ($input[$i] === ',') {
        $separators[] = $i;
    }
}
$separators[] = strlen($input);

$count = 0;
for ($i = 0; $i < count($separators) - 1; $i++) {
    $count += ($separators[$i + 1] - $separators[$i] - 1) % 2;
    for ($j = $separators[$i] + 1; $j < $separators[$i + 1]; $j++) {
        if ($input[$j] < '0' || $input[$j] > '9') {
            echo "You should have entered the numbers!\n";
            return;
        }
    }
}
echo $count . "\n";

?>
