package com.board.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.board.vo.BoardVo;
import com.board.menus.vo.MenuVo;

@Mapper
public interface BoardMapper {
	
	List<BoardVo> getBoardList(String menu_id);

	List<BoardVo> getBoardListAll();

	void insertBoard(BoardVo boardVo);

	void deleteBoard(BoardVo boardVo);

	BoardVo getBoard(BoardVo boardVo);

	void updateBoard(BoardVo boardVo);

	void updateHit(BoardVo vo);


}
