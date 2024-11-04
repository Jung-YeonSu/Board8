package com.board.menus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.menus.vo.MenuVo;

import lombok.NonNull;

@Mapper
public interface MenuMapper {

	List<MenuVo> getMenuList();

	void insertMenu(MenuVo menuVo);

	void insertMenu2(MenuVo menuvo);
	
	void deleteMenu(MenuVo menuVo);

	void updateMenu(MenuVo menuVo);

	MenuVo getMenu(MenuVo menuVo);

	List<MenuVo> getMenuNames();

}







