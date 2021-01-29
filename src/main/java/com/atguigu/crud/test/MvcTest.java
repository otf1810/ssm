package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.EmployeeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能，测试curd请求的正确性
 * Spring4测试的时候，需要servlet3.0的支持
 * @author lfy
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext-service.xml",
        "classpath:spring/applicationContext-dao.xml", "classpath:spring/springmvc.xml"})
@WebAppConfiguration
public class MvcTest {
    //传入SpringMVC的IOC容器
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求，获取到处理结果
    MockMvc mockMvc;
    
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    
    @Test
    public void test() throws Exception {
        //模拟请求拿到返回值
//        MvcResult result = mockMvc.perform
//                (MockMvcRequestBuilders.get("/emps").param("pageNum","2")).andReturn();
//        MockHttpServletRequest request = result.getRequest();
//        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
//        List<Employee> list = pageInfo.getList();
//        for (Employee employee : list) {
//            System.out.println(" " + employee.getId());
//        }


        MvcResult result = mockMvc.perform
                (MockMvcRequestBuilders.get("/depts")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        List<Department> depts = (List<Department>) request.getAttribute("depts");
        for (Department dept : depts) {
            System.out.println(dept);
        }


    }
    
    
    
    
    
    
    
}
