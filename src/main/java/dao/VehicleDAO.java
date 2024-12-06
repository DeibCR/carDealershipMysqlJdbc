package dao;

import model.Vehicle;

import java.util.List;

public interface VehicleDAO {

    List<Vehicle> findVehicleByPriceRange(double minPrice, double maxPrice);
    List<Vehicle> findVehicleByMakeModel( String make, String model);
    List<Vehicle> findVehicleByYear(int maxYear, int minYear);
    List<Vehicle> findVehicleByColor( String color);
    List<Vehicle> findVehicleByMileage( int minOdometer, int maxOdometer);
    List<Vehicle> findVehicleByType( String vehicleType);

}
