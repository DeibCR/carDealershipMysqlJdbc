package dao;

import model.Contract;

import javax.sql.DataSource;
import java.util.List;

public class ContractDAOMysqlJdbc implements ContractDAO{

    private final DataSource dataSource;

    public ContractDAOMysqlJdbc(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public List<Contract> findContractsByDealership(int dealershipID) {
        return null;
    }

    @Override
    public void addContract(Contract contract, int dealershipID) {

    }

    @Override
    public void deleteContract(int contractID) {

    }
}
