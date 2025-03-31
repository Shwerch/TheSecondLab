import java.util.Scanner;

public class java {
    public static void main(String[] args) {
        System.out.print("Enter the N number: ");
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