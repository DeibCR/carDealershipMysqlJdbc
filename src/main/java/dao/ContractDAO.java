package dao;

import model.Contract;

import java.util.List;

public interface ContractDAO {
    List<Contract> findContractsByDealership(int dealershipID);
    void addContract(Contract contract);
    void deleteContract(int contractID);

}
