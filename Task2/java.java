import java.util.Scanner;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        System.out.print("Enter the string of numbers with ',' separator: ");
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();
        scanner.close();

        ArrayList<Integer> separators = new ArrayList<Integer>();
        separators.add(-1);
        for (int i = 0; i < input.length(); i++)
            if (input.charAt(i) == ',')
               separators.add(i);
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