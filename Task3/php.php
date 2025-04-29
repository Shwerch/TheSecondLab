<?php

function enterPositiveNumber() {
    $number = 0;
    while (true) {
        $number = intval(readline());
        if ($number < 1) {
            echo "The number must be positive!\n";
        } else break;
    }
    return $number;
}

function enterCorrectNumbers($count) {
    $correctNumbers = [];
    for ($i = 0; $i < $count; $i++) {
        $summ = 0;
        $multi = 1;
        $number = enterPositiveNumber();

        while ($number > 0) {
            $digit = $number % 10;
            $summ += $digit;
            $multi *= $digit;
            $number /= 10;
            $number = intval($number); // Convert to integer to avoid float issues.
        }

        if ($summ < $multi) array_push($correctNumbers, $i);
    }
    return $correctNumbers;
}

echo "Enter the positive number of numbers to be entered: ";
$count = enterPositiveNumber();
echo "Enter numbers greater than zero: ";
$correctNumbers = enterCorrectNumbers($count);
echo "\n";

if (!empty($correctNumbers)) {
    echo implode(" ", $correctNumbers);
} else {
    echo "There are no numbers that match the condition";
}
echo "\n";
?>
