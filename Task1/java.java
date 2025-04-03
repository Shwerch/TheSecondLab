import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the N number: ");
        int num = scanner.nextInt();

        if (num < 1 || num > 26) {
            System.out.println("The N number must be from 1 to 26!");
            return;
        }

        for (int i = 0; i < num; i++) {
            for (int j = 0; j <= i; j++)
                System.out.print((char)(num - j - 1 + 'A') + " ");
            System.out.println();
        }
    }
}
