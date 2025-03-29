#include <iostream>

int main() {
    int num = 0;
    std::cin >> num;
    for (int i = 1; i <= num; i++) {
        for (int j = 1; j <= i; j++)
            std::cout << static_cast<char>(num - j + static_cast<int>('A')) << " ";
        std::cout << std::endl;
    }
    return 0;
}
