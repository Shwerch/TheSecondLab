const input: string = prompt("Enter the string of numbers with ' ' separator: ") || "-";

const separators: number[] = [-1];
for (let i = 0; i < input.length; i++) {
    if (input[i] === ' ') {
        separators.push(i);
    }
}
separators.push(input.length);

const numbers: string[][] = [];
for (let i = 0; i < separators.length - 1; i++) {
    const segment: string[] = [];
    for (let k = separators[i] + 1; k < separators[i + 1]; k++) {
        segment.push(input[k]);
    }
    numbers.push(segment);
}

const answer: number[] = [];
for (let i = 0; i < numbers.length; i++) {
    let summ = 0;
    let multi = 1;
    
    for (const j of numbers[i]) {
        const num: number = parseInt(j);
        
        if (isNaN(num) || num < 0 || num > 9) {
            console.log("You should have entered the numbers!");
            throw new Error("You should have entered the numbers!");
        }

       summ += num;
       multi *= num;
   }

   if (summ < multi) {
       answer.push(i);
   }
}

console.log(answer.join(' '));
if (answer.length > 0) console.log();
