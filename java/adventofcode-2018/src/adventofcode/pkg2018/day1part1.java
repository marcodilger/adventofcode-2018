/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adventofcode.pkg2018;

import java.util.ArrayList;
import java.io.File; 
import java.util.Scanner; 


/**
 *
 * @author marco
 */
public class day1part1 {
    public static void main(String[] args) {
        
        System.out.println("running");
        File file = new File(System.getProperty("user.home"), "/github/adventofcode-2018/data/day1part1.txt");
        System.out.println(file.getAbsolutePath());
        
        try {
        Scanner scanner = new Scanner(file);
        
        
        
        ArrayList<Integer> data = new ArrayList<Integer>();
        
        while (scanner.hasNextLine()) {
                data.add(Integer.parseInt(scanner.nextLine()));
        }
        
        int result = 0;
        for (int freq : data) {
            result = result + freq;
        }
        
        System.out.println("" + result);
        
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
