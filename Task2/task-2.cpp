#include <iostream>
#include <vector>
#include <string>

int main() {
    std::string input;
    std::cin >> input;

    std::vector<int> separators = {-1};
    int i;
    for (i = 0; i < input.length(); i++)
        if (input[i] == ',')
            separators.push_back(i);
    separators.push_back(i);

    int count = 0;
    for (int i = 0; i < separators.size() - 1; i++)
        count += (separators[i + 1] - separators[i] - 1) % 2;
    std::cout << count << std::endl;
    return 0;
}
