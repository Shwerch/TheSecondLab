function enterPositiveNumber() {
	let number;
	while (true) {
		number = parseInt(prompt("Enter a positive number: "));
		if (number < 1) {
			console.log("The number must be positive!");
		} else {
			break;
		}
	}
	return number;
}

function enterCorrectNumbers(count) {
	const correctNumbers = [];
	for (let i = 0; i < count; i++) {
		let summ = 0,
			multi = 1;
		let number = enterPositiveNumber();
		while (number > 0) {
			const digit = number % 10;
			summ += digit;
			multi *= digit;
			number = Math.floor(number / 10);
		}
		if (summ < multi) {
			correctNumbers.push(i);
		}
	}
	return correctNumbers;
}

console.log("Enter the positive number of numbers to be entered: ");
const count = enterPositiveNumber();
console.log("Enter numbers greater than zero:");
const correctNumbers = enterCorrectNumbers(count);
console.log();

if (correctNumbers.length > 0) {
	console.log(correctNumbers.join(" "));
} else {
	console.log("There are no numbers that match the condition");
}
