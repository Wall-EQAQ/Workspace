package com.dxd.firstcrud.service;

import com.dxd.firstcrud.bean.Department;
import com.dxd.firstcrud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description:firstcrud
 * @Created by Administrator on 2019/11/6 14:01
 * @Modified by:
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDept(){
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
