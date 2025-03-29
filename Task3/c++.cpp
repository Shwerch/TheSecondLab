#include <iostream>
#include <vector>
#include <string>

int main() {
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

    for (int i = 0; i < numbers.size(); i++) {
        int summ = 0, multi = 1;
        for (const char j : numbers[i]) {
            const int num = (j - '0');
            summ += num;
            multi *= num;
        }
        if (summ < multi)
            std::cout << i << " ";
    }
    std::cout << std::endl;

    return 0;
}