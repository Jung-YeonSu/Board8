package com.board.pds.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.board.pds.vo.PdsVo;

@Mapper
public interface PdsService {

	List<PdsVo> getPdsList(HashMap<String, Object> map);

}
