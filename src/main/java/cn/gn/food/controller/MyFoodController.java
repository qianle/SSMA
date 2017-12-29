package cn.gn.food.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.gn.food.service.MyFoodService;

/**
 * 后台验证步骤 1.javabean 添加验证注解 2.action中使用 @Valid 表示javabean
 * 使用Errirs或者BindingResult判断是否验证失败 3.出现jar包冲突 4.3.1
 * 
 * 
 * @author GuNiao
 * 
 */
@Controller
public class MyFoodController {
	@Autowired
	MyFoodService mdi;
	/**
	 * 直接返回对象 springmvc自动转换成json
	 * 
	 * 需要配置消息转换器
	 * @param foodname
	 * @param os
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/queryFoodList", method ={RequestMethod.GET,RequestMethod.POST})
	public List<Map<String, Object>> queryFoodList(String foodname, OutputStream os) throws Exception {
		List<Map<String, Object>> list = mdi.queryFood(foodname);
		return list;
	}
	/**
	 * 删除food
	 * @param foodId 菜品id
	 * @param os 输出流 输出到游览器
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/food/{id}",method=RequestMethod.DELETE)
	public String deleteFood(@PathVariable(value="id") String foodId,OutputStream os) throws Exception{
		
		try {
			mdi.deleteFood(foodId);
			os.write("1".getBytes("UTF-8"));
		} catch (Exception e) {
			os.write("0".getBytes("UTF-8"));
		}
		return null;
	}
	/**
	 * 修改food
	 * @param foodId 菜品id
	 * @param foodName 菜品名字
	 * @param price 菜品价格
	 * @param os 输出流 输出到游览器
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/food/{id}",method=RequestMethod.PUT)
	public String updateFood(@PathVariable(value="id") String foodId,String foodName,String price,OutputStream os) throws Exception{
		
		try {
			mdi.updateFood(foodId, foodName, price);
			os.write("1".getBytes("UTF-8"));
		} catch (Exception e) {
			os.write("0".getBytes("UTF-8"));
		}
		return null;
	}
	/**
	 * 新增food
	 * @param foodName 菜品名字
	 * @param price 菜品价格
	 * @param os 输出流 输出到游览器
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/food",method=RequestMethod.POST)
	public String saveFood(String foodName,String price,OutputStream os) throws Exception{
		
		try {
			mdi.saveFood(foodName, price);
			os.write("1".getBytes("UTF-8"));
		} catch (Exception e) {
			os.write("0".getBytes("UTF-8"));
		}
		return null;
	}

}
