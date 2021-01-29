package com.atguigu.crud.test;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
     * 测试dao层的工作
     * @author lfy
     *使用Spring的单元测试，可以自动注入我们需要的组件
     *1、导入SpringTest模块
     *2、@ContextConfiguration指定Spring配置文件的位置
     *3、直接autowired要使用的组件即可
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/applicationContext-dao.xml")
public class MapperTest {
    
    @Autowired
    EmployeeMapper employeeMapper;
    
    @Test
    public void test(){
        
//        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
//        System.out.println(employees);

//        System.out.println(employeeMapper.countByExample(null));

//        Employee employee = new Employee(null, "kobe", "1", "kobe@nba.com", 2);
//        employeeMapper.insert(employee);
    }
    
}
