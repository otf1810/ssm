package com.atguigu.crud.service.impl;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.dao.EmployeeMapper;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.bcel.internal.generic.NEW;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper empMapper;


    public Employee getEmpById(Integer id) {
        Employee employee = empMapper.selectByPrimaryKey(id);
//        System.out.println(employee);
        return employee;
    }

    public List<Employee> getAll() {
        List<Employee> employees = empMapper.selectByExampleWithDept(null);
        return employees;
    }

    public void addEmp(Employee employee) {
        empMapper.insertSelective(employee);
    }

    public boolean checkLastName(String lastName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andLastNameEqualTo(lastName);
        long count = empMapper.countByExample(example);
        return count == 0;
    }

    public void updateEmp(Employee employee) {
        empMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmpById(Integer id) {
        empMapper.deleteByPrimaryKey(id);
    }

    public void batchDelete(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ids);
        empMapper.deleteByExample(example);
    }

}
