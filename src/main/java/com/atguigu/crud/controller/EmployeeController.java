package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService empService;
    
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<Integer>();
            String[] str_ids = ids.split("-");
            for (String id : str_ids) {
                del_ids.add(Integer.parseInt(id));
            }
            empService.batchDelete(del_ids);
        }else{
            int id = Integer.parseInt(ids);
            empService.deleteEmpById(id);
        }
        return Msg.success();
    }
    
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        empService.updateEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = empService.getEmpById(id);
        return Msg.success().add("emp",employee);
    }
    
    @ResponseBody
    @RequestMapping("/checkLastName")
    public Msg checkLastName(@RequestParam("lastName") String lastName){
        //用户名的合法性校验
        String regex = "^[a-z0-9_-]{3,16}$";
        if (!lastName.matches(regex))
            return Msg.fail().add("va_msg","用户名格式不正确！");
        //用户名的唯一性校验
        boolean result = empService.checkLastName(lastName);
        if (result){
            return Msg.success();
        }
        return Msg.fail().add("va_msg","用户名已存在！");
    }
    
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg addEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()){
            Map<String, Object> errors = new HashMap<String, Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                errors.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errors",errors);
        }
        empService.addEmp(employee);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pageNum",defaultValue = "1") Integer pn){
        PageHelper.startPage(pn,2);
        List<Employee> employees = empService.getAll();
        PageInfo pageInfo = new PageInfo(employees,3);
        return Msg.success().add("pageInfo",pageInfo);
    }
    
    
//    @RequestMapping("/emps")
    public ModelAndView getEmps(@RequestParam(value = "pageNum",defaultValue = "1") Integer pn){
        ModelAndView mav = new ModelAndView();
        PageHelper.startPage(pn,2);
        List<Employee> employees = empService.getAll();
        PageInfo pageInfo = new PageInfo(employees,3);
        mav.addObject("pageInfo",pageInfo);
        mav.setViewName("list");
        return mav;
    }
}
