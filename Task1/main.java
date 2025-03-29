import java.util.Scanner;

public class main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int num = scanner.nextInt();
        scanner.close();
        for (int i = 1; i <= num; i++) {
            for (int j = 1; j <= i; j++)
                System.out.print((char)(num - j + (int)'A') + " ");
            System.out.print('\n');
        }
    }
}