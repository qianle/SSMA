package cn.gn.food.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cn.gn.food.dao.MyFoodDao;
import cn.gn.food.mapper.FoodMapper;


@Repository
public class MyFoodDaoImpl implements MyFoodDao {
	@Autowired
	FoodMapper mapper;
	/* (non-Javadoc)
	 * @see cn.gn.springmvc.lesson05.dao.MyFoodDao#queryFood(java.lang.String)
	 */
	public List<Map<String, Object>> queryFood(String foodName){
		return mapper.queryFood(foodName);
	}
	/* (non-Javadoc)
	 * @see cn.gn.springmvc.lesson05.dao.MyFoodDao#deleteFood(java.lang.String)
	 */
	public void deleteFood(String foodid) {
		mapper.deleteFood(foodid);

	}
	/* (non-Javadoc)
	 * @see cn.gn.springmvc.lesson05.dao.MyFoodDao#saveFood(java.lang.String, java.lang.String)
	 */
	public void saveFood(String foodName,String price) {
		mapper.saveFood(foodName, price);
	}
	/* (non-Javadoc)
	 * @see cn.gn.springmvc.lesson05.dao.MyFoodDao#updateFood(java.lang.String, java.lang.String, java.lang.String)
	 */
	public void updateFood(String foodId,String foodName,String price) {
		mapper.updateFood(foodId, foodName, price);
	}
}
