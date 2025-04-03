const input: string = prompt("Enter the string of numbers with ',' separator: ") || "-";

const separators: number[] = [-1];
for (let i = 0; i < input.length; i++) {
    if (input[i] === ',') {
        separators.push(i);
    }
}
separators.push(input.length);

let count: number = 0;
let error: boolean = false;
for (let i = 0; i < separators.length - 1; i++) {
    count += (separators[i + 1] - separators[i] - 1) % 2;
    for (let j = separators[i] + 1; j < separators[i + 1]; j++) {
        if (input[j] < '0' || input[j] > '9') {
            console.log("You should have entered the numbers!");
            error = true;
        }
    }
}
if (!error)
    console.log(count);
