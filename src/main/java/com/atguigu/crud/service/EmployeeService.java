package com.atguigu.crud.service;

import com.atguigu.crud.bean.Employee;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface EmployeeService {
    
    Employee getEmpById(Integer id);
    
    List<Employee> getAll();

    void addEmp(Employee employee);

    boolean checkLastName(String lastName);

    void updateEmp(Employee employee);

    void deleteEmpById(Integer id);

    void batchDelete(List<Integer> ids);
}
