import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {

    static int enterPositiveNumber(Scanner scanner) {
        int number = 0;
        while (true) {
            number = scanner.nextInt();
            if (number < 1) {
                System.out.println("The number must be positive!");
            } else {
                break;
            }
        }
        return number;
    }

    static List<Integer> enterCorrectNumbers(int count, Scanner scanner) {
        List<Integer> correctNumbers = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            int summ = 0, multi = 1;
            int number = enterPositiveNumber(scanner);
            while (number > 0) {
                int digit = number % 10;
                summ += digit;
                multi *= digit;
                number /= 10;
            }
            if (summ < multi) {
                correctNumbers.add(i);
            }
        }
        return correctNumbers;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the positive number of numbers to be entered: ");
        int number = enterPositiveNumber(scanner);
        System.out.print("Enter numbers greater than zero: ");
        List<Integer> correctNumbers = enterCorrectNumbers(number, scanner);
        System.out.println();

        if (!correctNumbers.isEmpty()) {
            for (int num : correctNumbers) {
                System.out.print(num + " ");
            }
        } else {
            System.out.println("There are no numbers that match the condition");
        }
        System.out.println();
    }
}
