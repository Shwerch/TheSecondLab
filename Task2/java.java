import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the string of numbers with ',' separator: ");
        String input = scanner.nextLine();

        List<Integer> separators = new ArrayList<>();
        separators.add(-1);
        for (int i = 0; i < input.length(); i++) {
            if (input.charAt(i) == ',') {
                separators.add(i);
            }
        }
        separators.add(input.length());

        int count = 0;
        for (int i = 0; i < separators.size() - 1; i++) {
            count += (separators.get(i + 1) - separators.get(i) - 1) % 2;
            for (int j = separators.get(i) + 1; j < separators.get(i + 1); j++) {
                if (input.charAt(j) < '0' || input.charAt(j) > '9') {
                    System.out.println("You should have entered the numbers!");
                    return;
                }
            }
        }
        System.out.println(count);
    }
}
