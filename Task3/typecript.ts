function enterPositiveNumber(): number {
	let number: number;

	while (true) {
		const input = prompt("Enter a positive number: ");
		if (input !== null) {
			// check for null in case of canceling prompt.
			number = parseInt(input);
			if (number < 1) {
				console.log("The number must be positive!");
			} else break;
		}
	}
	return number;
}

function enterCorrectNumbers(count: number): Array<number> {
	const correctNumbers: Array<number> = [];
	for (let i = 0; i < count; i++) {
		let summ = 0,
			multi = 1;
		const number: number = enterPositiveNumber();
		let tempNumber: number = number;

		while (tempNumber > 0) {
			const digit: number = tempNumber % 10;
			summ += digit;
			multi *= digit;
			tempNumber = Math.floor(tempNumber / 10);
		}

		if (summ < multi) correctNumbers.push(i);
	}
	return correctNumbers;
}

const count: number = enterPositiveNumber();
console.log("Enter numbers greater than zero:");
const correctNumbers: Array<number> = enterCorrectNumbers(count);
console.log();

if (correctNumbers.length > 0) console.log(correctNumbers.join(" "));
else console.log("There are no numbers that match the condition");
