package com.board.pds.controller;

import java.io.File;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.board.pds.mapper.PdsMapper;
import com.board.pds.vo.FilesVo;

@RestController // @Controller + @ResponseBody
public class PdsRestController {

	@Value("${part4.upload-path}")
	private String uploadPath;
	
	@Autowired
	private PdsMapper pdsMapper;
	
	@RequestMapping("/deleteFile")
	public void deleteFile(@RequestParam HashMap<String, Object> map) {
		
		Long file_num = Long.parseLong(String.valueOf(map.get("file_num")));         

		// 실제 파일 삭제
		FilesVo fileInfo = pdsMapper.getFileInfo(file_num);
		
		File file = new File(uploadPath + fileInfo.getSfilename());
		if(file.exists()) file.delete();
		
		// Files table 자료 삭제
		pdsMapper.deleteUploadFileNum(map);
		
	}
}
