const num: number = 4;
    
for (let i = 1; i <= num; i++) {
    let line = '';
    for (let j = 1; j <= i; j++) {
        const ch: string = String.fromCharCode(num - j + 'A'.charCodeAt(0));
        line += ch + ' ';
    }
    console.log(line.trim());
}