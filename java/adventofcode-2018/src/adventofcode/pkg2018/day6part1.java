/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adventofcode.pkg2018;

/**
 *
 * @author marco
 */

import java.io.File; 
import java.util.Scanner; 

public class day6part1 {
    public static void main(String[] args) {
        
        System.out.println("running");
        File file = new File(System.getProperty("user.home"), "/github/adventofcode-2018/data/day6.txt");
        System.out.println(file.getAbsolutePath());
        
        try {
        Scanner scanner = new Scanner(file);
        
        while (scanner.hasNextLine()) {
                String[] line = scanner.nextLine().split(", ");
                //x coord
                System.out.println(line[1]);

        }
        
        int result = 0;
        System.out.println("" + result);
        
        } catch (Exception e) {
            e.printStackTrace();
        }
    
    
    
}
