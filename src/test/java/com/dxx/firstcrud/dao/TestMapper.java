package com.dxx.firstcrud.dao;

import com.dxd.firstcrud.bean.Department;
import com.dxd.firstcrud.bean.Employee;
import com.dxd.firstcrud.dao.DepartmentMapper;
import com.dxd.firstcrud.dao.EmployeeMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * @Description:firstcrud
 * @Created by Administrator on 2019/10/28 12:35
 * @Modified by:
 *
 * 测试向数据库中插入500条数据
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestMapper {
    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    SqlSession sqlSession;

    public SqlSessionFactory getSqlSessionFactory() throws IOException {
        String resource="mybatis-config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resource);
        return new SqlSessionFactoryBuilder().build(inputStream);
    }


    @Test
    public void testInsertDepartment(){//添加2个部门
        DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
        mapper.insertSelective(new Department(null, "开发部"));
        mapper.insertSelective(new Department(null,"测试部"));
    }
    @Test
    public void testInsertPeople(){//添加500个员工

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i <500 ; i++) {
            //生成UUID作为用户名,以前5位作为用户名和邮箱
            String userId = UUID.randomUUID().toString().replace("-", "").substring(0,5);
            mapper.insertSelective(new Employee(null, userId, "M", userId + "@qq.com", 1));
        }



    }

    @Test
    public void test() throws IOException {
        SqlSessionFactory sqlSessionFactory=getSqlSessionFactory();
        //此处的openSession()方法不带参数，获取到的SqlSession不会自动提交，方法会有一个boolean类型的参数，值设置为true才会自动提交
        SqlSession sqlSession = sqlSessionFactory.openSession();
        try{
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            Map<String,Object> map=new HashMap<>();
            map.put("id",1);
            map.put("lastName","Tom");
            //手动提交一下
            sqlSession.commit();
        }finally {
            //用完了一定要关闭
            sqlSession.close();
        }
    }
}
