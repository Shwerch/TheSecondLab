#include <iostream>
#include <vector>
#include <string>

int main() {
    std::cout << "Enter the string of numbers with ' ' separator: ";
    std::string input;
    std::getline(std::cin, input);

    std::vector<int> separators = {-1};
    for (int i = 0; i < input.length(); i++)
        if (input[i] == ' ')
            separators.push_back(i);
    separators.push_back(static_cast<int>(input.length()));

    std::vector<std::vector<char>> numbers;
    for (int i = 0; i < separators.size() - 1; i++) {
        int j = i + 1;
        numbers.emplace_back();
        for (int k = separators[i] + 1; k < separators[j]; k++)
            numbers[i].push_back(input[k]);
    }

    std::vector<int> answer;
    for (int i = 0; i < numbers.size(); i++) {
        int summ = 0, multi = 1;
        for (const char j : numbers[i]) {
            const int num = (j - '0');
            if (num < 0 || num > 9) {
                std::cout << "You should have entered the numbers!" << std::endl;
                return 1;
            }
            summ += num;
            multi *= num;
        }
        if (summ < multi)
            answer.push_back(i);
    }
    for (int i: answer)
        std::cout << i << " ";
    std::cout << std::endl;

    return 0;
}