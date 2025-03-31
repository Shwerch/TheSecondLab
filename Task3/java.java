import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the string of numbers with ' ' separator: ");
        String input = scanner.nextLine();

        ArrayList<Integer> separators = new ArrayList<>();
        separators.add(-1);
        for (int i = 0; i < input.length(); i++) {
            if (input.charAt(i) == ' ') {
                separators.add(i);
            }
        }
        separators.add(input.length());

        ArrayList<ArrayList<Character>> numbers = new ArrayList<>();
        for (int i = 0; i < separators.size() - 1; i++) {
            int j = i + 1;
            ArrayList<Character> number = new ArrayList<>();
            for (int k = separators.get(i) + 1; k < separators.get(j); k++) {
                number.add(input.charAt(k));
            }
            numbers.add(number);
        }

        ArrayList<Integer> answer = new ArrayList<>();
        for (int i = 0; i < numbers.size(); i++) {
            int summ = 0, multi = 1;
            for (char j : numbers.get(i)) {
                int num = j - '0';
                if (num < 0 || num > 9) {
                    System.out.println("You should have entered the numbers!");
                    return;
                }
                summ += num;
                multi *= num;
            }
            if (summ < multi) {
                answer.add(i);
            }
        }

        for (int i : answer) {
            System.out.print(i + " ");
        }
        System.out.println();
        
        scanner.close();
    }
}
