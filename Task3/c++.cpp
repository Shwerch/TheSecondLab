#include <iostream>
#include <vector>

int enterPositiveNumber() {
	int number = 0;
	while (true) {
		std::cin.clear();
		std::cin >> number;
		if (number < 1)
			std::cout << "The number must be positive!" << std::endl;
		else
			break;
	}
	return number;
}

std::vector<int> enterCorrectNumbers(int number) {
	std::vector<int> correctNumbers;
	for (int i = 0; i < number; i++) {
		int summ = 0, multi = 1;
		for (int number = enterPositiveNumber(); number > 0; number /= 10) {
			int digit = number % 10;
			summ += digit;
			multi *= digit;
		}
		if (summ < multi)
			correctNumbers.push_back(i);
	}
	return correctNumbers;
}

int main() {
	std::cout << "Enter the positive number of numbers to be entered: ";
	int number = enterPositiveNumber();
	std::cout << "Enter a numbers greater than zero: ";
	std::vector<int> correctNumbers = enterCorrectNumbers(number);
	std::cout << std::endl;
	if (!correctNumbers.empty())
		for (int num : correctNumbers)
			std::cout << num << " ";
	else
		std::cout << "There are no numbers that match the condition";
	std::cout << std::endl;

	return 0;
}
