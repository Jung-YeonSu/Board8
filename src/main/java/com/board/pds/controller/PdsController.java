package com.board.pds.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.board.menus.mapper.MenuMapper;
import com.board.menus.vo.MenuVo;
import com.board.paging.vo.Pagination;
import com.board.paging.vo.PagingResponse;
import com.board.paging.vo.SearchVo;
import com.board.pds.mapper.PdsMapper;
import com.board.pds.service.PdsService;
import com.board.pds.vo.FilesVo;
import com.board.pds.vo.PdsVo;

import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/Pds")
public class PdsController {
	
	@Value("${part4.upload-path}")
	private String     uploadPath;

	@Autowired
	private PdsService pdsService;

	@Autowired
	private MenuMapper menuMapper;

	@Autowired
	private PdsMapper pdsMapper;

	@RequestMapping("/List")
	public ModelAndView list(@RequestParam HashMap<String, Object> map) {
		List<MenuVo> menuList = menuMapper.getMenuList();

		// 자료실 목록 준비 (data list : 10개 record)
		// menu_id,offset,recordSize
		// 전체 레코드 갯수 조회
		int count = pdsMapper.count(map.get("menu_id"));

		// 자료수가 0일 때 처리
		PagingResponse<PdsVo> response = null;
		if (count < 1) { // 현재 조회한 자료가 없다면
			response = new PagingResponse<>(Collections.emptyList(), null);
		}
		
	    // 페이징을 위한 초기 설정
	    SearchVo searchVo = new SearchVo();
	    int nowpage = Integer.parseInt(String.valueOf(map.get("nowpage")));
	    searchVo.setPage(nowpage);      // 현재 페이지 정보
	    searchVo.setRecordSize(10);     // 페이지당 10개
	    searchVo.setPageSize(10);       // paging.jsp에 출력할 페이지번호수
	    
	    // Pagination 설정
	    Pagination pagination = new Pagination(count, searchVo);
	    searchVo.setPagination(pagination);
	    int 	offset		= searchVo.getOffset();
	    int		recordSize	= searchVo.getRecordSize();	
	    // title,writer,content : 검색어 주제
	    map.put("title", 	map.get("title"));
	    map.put("writer", 	map.get("writer"));
	    map.put("content", 	map.get("content"));
		map.put("offset", offset);
		map.put("recordSize", recordSize);
		map.put("search", map.get("search"));
		map.put("searchText", map.get("searchtext"));
		
		List<PdsVo> pdsList = pdsService.getPdsPagingList(map);
		response = new PagingResponse<>(pdsList, pagination);
		System.out.println(map);
		ModelAndView mv = new ModelAndView();
		mv.addObject("menuList", menuList);
		mv.addObject("map", map);
		mv.addObject("searchVo", searchVo);
		mv.addObject("response", response);
		mv.setViewName("pds/list");
		return mv;
	}

	@RequestMapping("/WriteForm")
	public ModelAndView writeForm(@RequestParam HashMap<String, Object> map) {
		List<MenuVo> menuList = menuMapper.getMenuList();
		ModelAndView mv = new ModelAndView();
		mv.addObject("menuList", menuList);
		mv.addObject("map", map);
		mv.setViewName("pds/writeForm");
		return mv;
	}

	// /Pds/Write : 자료실 저장
	// map : menu_id, nowpage,title, writer, content
	// MultipartFile : upload 몇개의 파일 (<=HttpServletRequset(request))
	@RequestMapping("/Write")
	public ModelAndView write(@RequestParam HashMap<String, Object> map,
			@RequestParam(value = "upfile") MultipartFile[] uploadfiles) {

		// 저장
		// 1. map 정보
		// 새글 추가 -> db : Board table 저장
		// 2. MultipartFile[] 처리
		// 2-1. 실제폴더에 파일 저장(중폭파일처리) -> uploadPath(d:\dev\data\)
		// 2-2. 저장된 파일 정보를 DB에 저장 -> Files table 에

		pdsService.setWrite(map, uploadfiles);
		ModelAndView mv = new ModelAndView();
		String fmt = "redirect:/Pds/List?menu_id=%s&nowpage=%s";
		String loc = String.format(fmt, map.get("menu_id"), map.get("nowpage"));
		mv.setViewName(loc);
		return mv;
	}

	@RequestMapping("/View")
	public ModelAndView view(@RequestParam HashMap<String, Object> map) {
		List<MenuVo> menuList = menuMapper.getMenuList();
		
		// 조회수 증가
		pdsService.setReadCountUpdate(map);
		
		// 조회할 자료실 게시물 정보 (idx)
		PdsVo pdsVo = pdsService.getPds(map);

		// 조회할 파일 정보
		List<FilesVo> fileList = pdsService.getFileList(map);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("map",map);
		mv.addObject("menuList",menuList);
		mv.addObject("vo",pdsVo);
		mv.addObject("fileList",fileList);
		mv.setViewName("pds/view");
		return mv;
	}
	
	@RequestMapping("/Delete")
	public ModelAndView delete(
			@RequestParam HashMap<String, Object> map
			) {
		pdsService.setDelete(map);
		
		ModelAndView mv = new ModelAndView();
		String fmt = "redirect:/Pds/List?menu_id=%s&nowpage=%s";
		String loc = String.format(fmt, String.valueOf(map.get("menu_id")),String.valueOf(map.get("nowpage")));
		System.out.println(loc);
		mv.setViewName(loc);
		return mv;
	}
	
	@RequestMapping("/UpdateForm")
	public ModelAndView updateForm(@RequestParam HashMap<String, Object> map) {
		List<MenuVo> menuList = menuMapper.getMenuList();
		
		
		PdsVo vo = pdsService.getPds(map);
		
		List<FilesVo> fileList = pdsService.getFileList(map);
	
		ModelAndView mv = new ModelAndView();
		mv.addObject("map",map);
		mv.addObject("menuList",menuList);
		mv.addObject("vo",vo);
		mv.addObject("fileList",fileList);
		mv.setViewName("pds/updateForm");
		return mv;
	}
	
	@RequestMapping("/Update")
	public ModelAndView update(
			@RequestParam HashMap<String, Object> map,
			@RequestParam(value = "upfile") MultipartFile[] uploadfiles) {
		System.out.println(uploadfiles);
		pdsService.setUpdate(map,uploadfiles);
		
		ModelAndView mv = new ModelAndView();
		String fmt = "redirect:/Pds/List?menu_id=%s&nowpage=%s";
		String loc = String.format(fmt, map.get("menu_id"),map.get("nowpage"));
		mv.setViewName(loc);
		return mv;
	}
	
	//--------------------------------------------------------------------------
	// 파일다운로드
	// 서버에서 바이너리 데이터를 다운받는다. : data 덩어리
	//--------------------------------------------------------------------------
	@GetMapping("/filedownload/{file_num}")
	@ResponseBody
	public void downloadFile(
			HttpServletResponse response,
			@PathVariable(value="file_num") Long file_num
			) throws UnsupportedEncodingException {
			
			// 파일을 조회
			FilesVo fileInfo = pdsService.getFileInfo(file_num);
			System.out.println(fileInfo);
			
			// 파일경로 (java.nio.file.Path)
			Path   saveFilePath = Paths.get(
					uploadPath
					+ java.io.File.separator
					+ fileInfo.getSfilename()
			);		
		   
		    // http 헤더 설정
			setFileHeader(response,fileInfo);
			
	        // 파일 복사 -> 함수 (서버 -> 클라이언트)
			fileCopy(response,saveFilePath);
		
	}


	// 다운받을 파일의 header 정보 설정
	private void setFileHeader(HttpServletResponse response, FilesVo fileInfo) 
			throws UnsupportedEncodingException {
		
		// 다운받을 때 파일명 설정
		response.setHeader("Content-Disposition",
	              "attachment; filename=\"" +  
	                 URLEncoder.encode(
	                 (String) fileInfo.getFilename(), "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", "application/download; utf-8");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
	}
	
	// 파일복사 : 실제 바이너리 데이터를 다운로드
	private void fileCopy(HttpServletResponse response, Path saveFilePath) {
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(saveFilePath.toFile());
			FileCopyUtils.copy(fis, response.getOutputStream());
			response.getOutputStream().flush(); // 버퍼에 남아있는 데이터 다 보내라
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
