package dao;

import model.Contract;

import java.util.List;

public interface ContractDAO {
    List<Contract> findContractsByDealership(int dealershipID);
    void addContract(Contract contract, int dealershipID);
    void deleteContract(int contractID);

}
