package com.dxd.firstcrud.controller;

import com.dxd.firstcrud.bean.Employee;
import com.dxd.firstcrud.bean.Msg;
import com.dxd.firstcrud.dao.EmployeeMapper;
import com.dxd.firstcrud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.omg.CORBA.portable.InvokeHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.lang.reflect.InvocationHandler;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:firstcrud
 * @Created by Administrator on 2019/10/31 11:01
 * @Modified by:
 */
@Controller
public class EmployeeController {


    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer  empId){//@PathVariable表示从请求路径中获得的id
        Employee employee=employeeService.getEmp(empId);
        return Msg.success().add("emp",employee);
    }
    //查询所有员工
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmployees(@RequestParam(value = "pageNumber",defaultValue = "1") Integer pageNumber){
        //startPage(int pageNum, int pageSize),传入起始页的页码和每页显示的记录数
        PageHelper.startPage(pageNumber,5);
        //只有紧跟在PageHelper.startPage方法后的第一个Mybatis的查询（Select）方法会被分页
        List<Employee> employees = employeeService.getAll();
        //PageInfo对象中封装了返回的信息,第一个参数为封装的对象，第二个是需要连续显示的页码
        PageInfo pi=new PageInfo(employees,5);
        //这里需要额外的Map来封装对象信息
        return Msg.success().add("pageInfo",pi);

    }

    //新增(保存)员工
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmployee(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors=result.getFieldErrors();
            for (FieldError fieldError:errors) {
                System.out.println("错误的字段名"+fieldError.getField());
                System.out.println("错误信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.failure().add("errorFields",map);
        }else {
            employeeService.saveEmployee(employee);
            return Msg.success();
        }
    }

    //校验用户名
    @ResponseBody
    @RequestMapping(value = "/checkname",method = RequestMethod.POST)
    public Msg checkEmployeeName(@RequestParam("empName") String empName){
        boolean b = employeeService.checkEmployeeName(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.failure();
        }
    }

    //校验邮箱
    @ResponseBody
    @RequestMapping(value = "/checkemail",method = RequestMethod.POST)
    public Msg checkEmployeeEmail(@RequestParam("empEmail") String empEmail){
        boolean b = employeeService.checkEmployeeEmail(empEmail);
        if (b){
            return Msg.success();
        }else {
            return Msg.failure();
        }
    }


}
