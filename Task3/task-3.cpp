#include <iostream>
#include <vector>
#include <string>

int main() {
    std::string input;
    std::getline(std::cin, input);

    std::vector<int> separators = {-1};
    int i;
    for (i = 0; i < input.length(); i++)
        if (input[i] == ' ')
            separators.push_back(i);
    separators.push_back(i);

    std::vector<std::vector<char>> numbers;
    for (int i = 0; i < separators.size() - 1; i++) {
        int j = i + 1;
        numbers.push_back({});
        for (int k = separators[i] + 1; k < separators[j]; k++)
            numbers[i].push_back(input[k]);
    }

    for (int i = 0; i < numbers.size(); i++) {
        int summ = 0, multi = 1;
        for (int j = 0; j < numbers[i].size(); j++) {
            int num = (numbers[i][j] - '0');
            summ += num;
            multi *= num;
        }
        if (summ < multi)
            std::cout << i << " ";
    }
    std::cout << std::endl;

    return 0;
}
