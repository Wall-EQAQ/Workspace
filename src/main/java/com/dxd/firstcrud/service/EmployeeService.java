package com.dxd.firstcrud.service;

import com.dxd.firstcrud.bean.Employee;
import com.dxd.firstcrud.bean.EmployeeExample;
import com.dxd.firstcrud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description:firstcrud
 * @Created by Administrator on 2019/10/31 11:49
 * @Modified by:
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;
    //查询所有员工方法
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    //添加员工
    public void saveEmployee(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    //校验员工姓名是否可用
    public boolean checkEmployeeName(String empName){

        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        //countByExample带条件的查询，会返回一个数，如果查询有符合条件的则返回一个大于0的整数，否则返回0
        long count = employeeMapper.countByExample(example);
        //返回的结果是一个判断，如果结果为true 则数据库中不存在这个人名，则新增的员工姓名可以
        return count==0;
    }
    //校验员工邮箱是否可用
    public boolean checkEmployeeEmail(String email){
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmailEqualTo(email);
        long count=employeeMapper.countByExample(example);
        return count==0;
    }

    //按照员工id查询员工
    public Employee getEmp(Integer empId) {
        Employee employee = employeeMapper.selectByPrimaryKey(empId);
        return employee;
    }
}
