package dealershipAppJDBC;

import com.mysql.cj.jdbc.MysqlDataSource;
import dao.VehicleDAO;
import dao.VehicleDAOMysqlJdbc;
import model.*;

import javax.sql.DataSource;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.Scanner;
import java.text.MessageFormat;

public class UserInterface {

    private Dealership dealership;
    private final VehicleDAO vehicleDAO;
    private final Scanner scanner;
    private static final ResourceBundle rB = ResourceBundle.getBundle("messages");


    public UserInterface() {

        scanner = new Scanner(System.in);

        Properties dbProperties = new Properties();

        try (FileInputStream fis = new FileInputStream("credentials.properties")) {
            dbProperties.load(fis);
        } catch (IOException e) {
            throw new RuntimeException("Error loading database configuration: " + e.getMessage());
        }

       DataSource dataSource= createDataSource(dbProperties);
        this.vehicleDAO=new VehicleDAOMysqlJdbc(dataSource);
    }

    private DataSource createDataSource(Properties dbProperties) {
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setURL(dbProperties.getProperty("db.url"));
        dataSource.setUser(dbProperties.getProperty("db.username"));
        dataSource.setPassword(dbProperties.getProperty("db.password"));
        return dataSource;
    }



    private void init() {

        dealership = new Dealership(1,"D & B Used Cars", "111 Old Benbrook Rd", "817-555-5555");

    }

    public void display() {
        init();

        boolean exit = false;
        while (!exit) {


            displayMenu();
            int input = getUserInput();
            exit = processInput(input);
        }
    }

    private void displayMenu() {
        System.out.println(rB.getString("menu.borderLine"));
        System.out.println(rB.getString("menu.title"));

        String header = MessageFormat.format(rB.getString("menu.header"),
                dealership.getName(),
                dealership.getAddress(),
                dealership.getPhone()
        );
        System.out.println(header);

        System.out.println(rB.getString("menu.borderLine"));

        for (int i = Integer.parseInt(rB.getString("first.option")); i <= Integer.parseInt(rB.getString("last.option")); i++) {
            String optionKey = "menu.option" + i;
            System.out.println(rB.getString(optionKey));
        }
        System.out.print(rB.getString("menu.prompt"));
    }

    private int getUserInput() {
        try {
            return Integer.parseInt(scanner.nextLine());
        } catch (NumberFormatException e) {
            System.out.println(rB.getString("error.input"));
            return -1;
        }
    }

    private boolean processInput(int input) {
        switch (input) {
            case 1:
                getAllVehicles();
                return false;
            case 2:
                addVehicleRequest();
                return false;
            case 3:
                removeVehicle();
                return false;
            case 4:
                searchByPrice();
                return false;
            case 5:
                searchByMakeAndModel();
                return false;
            case 6:
                searchByColor();
                return false;
            case 7:
                searchByType();
                return false;
            case 8:
                searchByMileage();
                return false;
            case 9:
                searchByYear();
                return false;
            case 10:
                getAllContracts();
                return false;
            case 11:
                addContractRequest();
                return false;
            case 12:
                System.out.println(rB.getString("exit.output"));
                return true;
            default:
                System.out.println(rB.getString("error.input"));
                return false;
        }
    }

    public void getAllVehicles() {
        headerDisplay();
        vehicleDAO.findAllVehicles().forEach(System.out::println);
    }

    public void getAllContracts() {
        List<Contract> contracts = dealership.getAllContracts();
        if (contracts.isEmpty()) {
            System.out.println(rB.getString("contracts.error"));
        } else {
            headerDisplayContracts();
            contracts.forEach(contract -> System.out.println(contract.getRepresentation()));
        }
    }

    public void addContractRequest() {

    }

    private void addVehicleRequest() {
        try {
            String vin = promptForString(rB.getString("vin.request"));
            int year = promptForInt(rB.getString("year.request"));
            String make = promptForString(rB.getString("make.request"));
            String model = promptForString(rB.getString("model.request"));
            String type = promptForString(rB.getString("type.request"));
            String color = promptForString(rB.getString("color.request"));
            int mileage = promptForInt(rB.getString("mileage.request"));
            double price = promptForDouble(rB.getString("price.request"));
            boolean sold=promptForBoolean(rB.getString("sold.request"));

            vehicleDAO.addVehicle(new Vehicle(vin,year,make,model,type,color,mileage,price,sold));
            System.out.println(rB.getString("added.request"));
            saveDealershipData();
        } catch (NumberFormatException e) {
            System.out.println(rB.getString("request.error"));
        }

    }

    private void removeVehicle() {
        try {

            String vin = promptForString(rB.getString("remove.vin.request"));
            boolean removed= vehicleDAO.removeVehicle(vin);

            if (removed) {
                System.out.println(rB.getString("remove1") + vin + rB.getString("remove2"));
                saveDealershipData();
            } else {
                System.out.println(rB.getString("remove1") + vin + rB.getString("remove2"));
            }
        } catch (Exception e) {
            System.out.println(rB.getString("remove.error2"));
        }



    }



    private void searchByPrice() {
        double minPrice = promptForDouble(rB.getString("search.price1"));
        double maxPrice = promptForDouble(rB.getString("search.price2"));
        headerDisplay();
        vehicleDAO.findVehicleByPriceRange(minPrice, maxPrice).forEach(System.out::println);
    }


    private void searchByMakeAndModel() {
        String make = promptForString(rB.getString("search.make"));
        String model = promptForString(rB.getString("search.model"));
        headerDisplay();
        vehicleDAO.findVehicleByMakeModel(make, model).forEach(System.out::println);
    }

    private void searchByColor() {
        String color = promptForString(rB.getString("search.color"));
        headerDisplay();
        vehicleDAO.findVehicleByColor(color).forEach(System.out::println);
    }

    private void searchByType() {
        String type = promptForString(rB.getString("search.type"));
        headerDisplay();
        vehicleDAO.findVehicleByType(type).forEach(System.out::println);
    }

    private void searchByMileage() {
        int minMileage = promptForInt(rB.getString("search.mileage1"));
        int maxMileage = promptForInt(rB.getString("search.mileage2"));
        headerDisplay();
        vehicleDAO.findVehicleByMileage(minMileage, maxMileage).forEach(System.out::println);

    }

    private void searchByYear() {
        int minYear = promptForInt(rB.getString("search.year.min"));
        int maxYear = promptForInt(rB.getString("search.year.max"));
        headerDisplay();
        vehicleDAO.findVehicleByYear(maxYear,minYear).forEach(System.out::println);
    }

    //helpers methods to clean the code:

    public void headerDisplay() {
        System.out.println(rB.getString("header.display"));
    }

    private void headerDisplayContracts() {
        //TODO: modify the display of this header to match the values

        System.out.println("""
                --------------------------------------------------------------------------------------------
                                                All Contracts
                Date       Customer Name   Customer Email           Vehicle Sold
                --------------------------------------------------------------------------------------------
                """);
    }

    /* these methods help  for those repetitive actions, the simple actions that you always need to do
      help to reduce visual noise
   */


    private int promptForInt(String message) {
        System.out.print(message);
        return Integer.parseInt(scanner.nextLine());
    }

    private String promptForString(String message) {
        System.out.print(message);
        return scanner.nextLine();
    }

    private double promptForDouble(String message) {
        System.out.print(message);
        return Double.parseDouble(scanner.nextLine());
    }

    private boolean promptForBoolean(String message) {
        System.out.print(message);
        return Boolean.parseBoolean(scanner.nextLine());
    }

    private void saveDealershipData() {
    }


}
