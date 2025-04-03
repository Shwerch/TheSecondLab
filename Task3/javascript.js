const input = prompt("Enter the string of numbers with ' ' separator: ");

const separators = [-1];
for (let i = 0; i < input.length; i++) {
    if (input[i] === ' ') {
        separators.push(i);
    }
}
separators.push(input.length);

const numbers = [];
for (let i = 0; i < separators.length - 1; i++) {
    numbers.push([]);
    for (let k = separators[i] + 1; k < separators[i + 1]; k++) {
        numbers[i].push(input[k]);
    }
}

const answer = [];
for (let i = 0; i < numbers.length; i++) {
    let summ = 0, multi = 1;
    for (const j of numbers[i]) {
        const num = j - '0';
        if (num < 0 || num > 9) {
            console.log("You should have entered the numbers!");
            return;
        }
        summ += num;
        multi *= num;
    }
    if (summ < multi) {
        answer.push(i);
    }
}

console.log(answer.join(' '));
if (answer.length > 0) {
    console.log();
}