#include <iostream>

int main() {
    int num = 0;
    std::cout << "Enter the N number from 1 to 26: ";
    std::cin >> num;
    if (num < 1 || num > 26) {
        std::cout << "The N number must be from 1 to 26!" << std::endl;
        return 1;
    }
    for (int i = 0; i < num; i++) {
        for (int j = 0; j < i + 1; j++)
            std::cout << static_cast<char>(num - j - 1 + static_cast<int>('A')) << ' ';
        std::cout << std::endl;
    }
    return 0;
}
