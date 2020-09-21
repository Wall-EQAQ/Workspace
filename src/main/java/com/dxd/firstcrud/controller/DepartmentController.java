package com.dxd.firstcrud.controller;

import com.dxd.firstcrud.bean.Department;
import com.dxd.firstcrud.bean.Msg;
import com.dxd.firstcrud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Description:firstcrud
 * @Created by Administrator on 2019/11/6 14:11
 * @Modified by:
 */
@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @ResponseBody
    @RequestMapping(value = "/depts",method = RequestMethod.GET)
    public Msg getDepartnment(){
        List<Department> departmentList = departmentService.getDept();
        return Msg.success().add("deptInfo",departmentList);
    }
}
