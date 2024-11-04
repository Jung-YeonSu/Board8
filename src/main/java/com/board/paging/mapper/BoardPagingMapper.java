package com.board.paging.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.board.vo.BoardVo;

@Mapper
public interface BoardPagingMapper {

	int count(BoardVo boardVo);


	List<BoardVo> getBoardPagingList(String menu_id, String title, String content, String writer, int offset,
			int recordSize);

	List<BoardVo> getAllBoardPagingList(String title, String content, String writer, int offset,
			int recordSize);

	int countAll(BoardVo boardVo);


	BoardVo getBoard(BoardVo boardVo);


	void incHit(BoardVo boardVo);


	void insertBoard(BoardVo boardVo);


	void deleteBoard(BoardVo vo);


	void updateBoard(BoardVo boardVo);

}
