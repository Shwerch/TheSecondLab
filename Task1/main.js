const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function main() {
    rl.question('Enter a number: ', (input) => {
        const num = parseInt(input);
    }
    
    for (let i = 1; i <= num; i++) {
        let line = '';
        for (let j = 1; j <= i; j++) {
            const ch = String.fromCharCode(num - j + 'A'.charCodeAt(0));
            line += ch + ' ';
        }
        console.log(line.trim());
    }
}