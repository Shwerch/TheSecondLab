#include <iostream>

int main() {
    int num = 0;
    std::cout << "Enter the N number: ";
    std::cin >> num;
    for (int i = 0; i < num; i++) {
        for (int j = 0; j < i + 1; j++)
            std::cout << static_cast<char>(num - j - 1 + static_cast<int>('A')) << " ";
        std::cout << std::endl;
    }
    return 0;
}
