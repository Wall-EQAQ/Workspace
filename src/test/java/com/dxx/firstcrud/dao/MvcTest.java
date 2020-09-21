package com.dxx.firstcrud.dao;

import com.dxd.firstcrud.bean.Employee;
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
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @Description:firstcrud
 * @Created by Administrator on 2019/10/31 10:59
 * @Modified by:
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
@WebAppConfiguration
public class MvcTest {

    //1传入springmvc的ioc
    @Autowired
    private WebApplicationContext wac;

    private MockMvc mockMvc;
    //2初始化MockMvc
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
    }

    //模拟测试失败，一直提示空指针异常
    @Test
    public void test() throws Exception {
        //3构建请求
        MockHttpServletRequestBuilder requestBuilder = MockMvcRequestBuilders.get("/emps").param("pageNumber","5");
        ResultActions resultActions = mockMvc.perform(requestBuilder);
        //4拿到返回值
        MvcResult mvcResult = resultActions.andReturn();
        //MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNumber","5")).andReturn();
        //5返回值中包含pageInfo，取出pageInfo进行校验
        MockHttpServletRequest request = mvcResult.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        //System.out.println("总页码数:"+pi.getPages());
//        List<Employee> list = pi.getList();
//        for (Employee e:list) {
//            System.out.println(e.getdId()+"   "+e.getEmpName());
//        }
    }
}
