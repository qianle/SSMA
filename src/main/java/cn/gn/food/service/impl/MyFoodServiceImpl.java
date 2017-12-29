package cn.gn.food.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import cn.gn.food.dao.MyFoodDao;
import cn.gn.food.service.MyFoodService;


@Service
public class MyFoodServiceImpl implements MyFoodDao, MyFoodService {
	@Autowired
	MyFoodDao dao;
	/* (non-Javadoc)
	 * @see cn.gn.springmvc.lesson05.dao.MyFoodDao#queryFood(java.lang.String)
	 */
	/* (non-Javadoc)
	 * @see cn.gn.food.service.impl.MyFoodService#queryFood(java.lang.String)
	 */
	public List<Map<String, Object>> queryFood(String foodName){
	
		return dao.queryFood(foodName);
	}
	/* (non-Javadoc)
	 * @see cn.gn.springmvc.lesson05.dao.MyFoodDao#deleteFood(java.lang.String)
	 */
	/* (non-Javadoc)
	 * @see cn.gn.food.service.impl.MyFoodService#deleteFood(java.lang.String)
	 */
	public void deleteFood(String foodid) {
		dao.deleteFood(foodid);
	}
	/* (non-Javadoc)
	 * @see cn.gn.springmvc.lesson05.dao.MyFoodDao#saveFood(java.lang.String, java.lang.String)
	 */
	/* (non-Javadoc)
	 * @see cn.gn.food.service.impl.MyFoodService#saveFood(java.lang.String, java.lang.String)
	 */
	public void saveFood(String foodName,String price) {
		dao.saveFood(foodName, price);
	}
	/* (non-Javadoc)
	 * @see cn.gn.springmvc.lesson05.dao.MyFoodDao#updateFood(java.lang.String, java.lang.String, java.lang.String)
	 */
	/* (non-Javadoc)
	 * @see cn.gn.food.service.impl.MyFoodService#updateFood(java.lang.String, java.lang.String, java.lang.String)
	 */
	public void updateFood(String foodId,String foodName,String price) {
		dao.updateFood(foodId, foodName, price);
	}
}
