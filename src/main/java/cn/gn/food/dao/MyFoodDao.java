package cn.gn.food.dao;

import java.util.List;
import java.util.Map;

public interface MyFoodDao {

	public abstract List<Map<String, Object>> queryFood(String foodName);

	public abstract void deleteFood(String foodid);

	public abstract void saveFood(String foodName, String price);

	public abstract void updateFood(String foodId, String foodName, String price);

}