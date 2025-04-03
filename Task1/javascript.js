const num = parseInt(prompt("Enter the N number: "), 10);

if (num < 1 || num > 26) {
    console.log("The N number must be from 1 to 26!");
} else {
    for (let i = 0; i < num; i++) {
        let row = '';
        for (let j = 0; j <= i; j++) {
            row += String.fromCharCode(num - j - 1 + 'A'.charCodeAt(0)) + ' ';
        }
        console.log(row);
    }
}
