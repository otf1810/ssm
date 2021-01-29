package com.atguigu.crud.bean;

import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer id;
    @Pattern(regexp = "(^[a-z0-9_-]{3,16}$)",message = "用户名格式不正确")
    private String lastName;

    private String gender;
    
    //    @Email
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
            message = "邮箱格式不正确")
    private String email;

    private Integer deptId;
    
    private Department department;

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName == null ? null : lastName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public Employee(Integer id, String lastName, String gender, String email, Integer deptId) {
        this.id = id;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.deptId = deptId;
    }

    public Employee() {
    }
}