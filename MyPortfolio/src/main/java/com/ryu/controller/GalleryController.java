package com.ryu.controller;


import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.util.IOUtils;
import com.ryu.common.Criteria;
import com.ryu.common.PageDTO;
import com.ryu.dto.BoardDTO;
import com.ryu.dto.GalleryDTO;
import com.ryu.service.GalleryService;
import com.ryu.service.S3Service;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class GalleryController {
	
	@Setter(onMethod_ =  @Autowired)
	private S3Service service;
	
	@Setter(onMethod_ =  @Autowired)
	private GalleryService galleryService;
	
	ModelAndView mv = new ModelAndView();
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}//getFolder end
	
	@RequestMapping(value="/gallery", method=RequestMethod.GET)
	public ModelAndView getList(Criteria cri) {
		
		cri.setAmount(12);
		List<GalleryDTO> list = galleryService.getListWithPaging(cri);
		
		for (GalleryDTO dto : list) {
			String temp = dto.getUploadPath().replaceAll("\\\\", "/");
			dto.setUploadPath(temp);
			temp = service.getS3(temp + "/s_" + dto.getUuid() +"_" +dto.getFileName());
			dto.setTotalUri(temp);
		}
		
		int total = galleryService.getTotalCount(cri);
		PageDTO dto = new PageDTO(cri, total);
		mv.setViewName("/gallery/list");
		mv.addObject("list", list);
		mv.addObject("pageMaker", dto);
		return mv;
	}
	
	
	@RequestMapping(value="/gallery/new", method=RequestMethod.GET)
	public ModelAndView uploadForm() {
		mv.setViewName("/gallery/upload");
		return mv;
	}//작성 폼 호출
	
	@RequestMapping(value="/gallery/new", method=RequestMethod.POST)
	public String uploadForm(GalleryDTO dto) {
		log.info(dto.toString());
		galleryService.setInsert(dto);
		return "redirect:/gallery";
	}//입력 
	
	@RequestMapping(value="/gallery/{gno}", method=RequestMethod.GET)
	public ModelAndView getRead(@PathVariable("gno") long gno, Criteria cri) {
		GalleryDTO dto = galleryService.getRead(gno);
		String temp = dto.getUploadPath().replaceAll("\\\\", "/");
		dto.setUploadPath(temp);
		temp = service.getS3(temp + "/" + dto.getUuid() +"_" +dto.getFileName());
		dto.setTotalUri(temp);
		mv.addObject("dto", dto);
		mv.addObject("cri", cri);
		mv.setViewName("/gallery/get");
		return mv;
	}//조회
	
	@RequestMapping(value="/gallery/{gno}/edit", method=RequestMethod.GET)
	public ModelAndView setUpdate(@PathVariable("gno") long gno, Criteria cri) {
		GalleryDTO dto = galleryService.getRead(gno);
		String temp = dto.getUploadPath().replaceAll("\\\\", "/");
		dto.setUploadPath(temp);
		temp = service.getS3(temp + "/" + dto.getUuid() +"_" +dto.getFileName());
		dto.setTotalUri(temp);
		mv.addObject("dto", dto);
		mv.addObject("cri", cri);
		mv.setViewName("/gallery/modify");
		return mv;
	}//수정폼 호출
	
	@RequestMapping(value="/gallery/{gno}", method=RequestMethod.PUT)
	public String setUpdate(GalleryDTO dto, Criteria cri, @PathVariable("gno") long gno) {
		galleryService.setUpdate(dto);
		return "redirect:/gallery";
	}//수정하기
	
	@RequestMapping(value="/gallery/{gno}", method=RequestMethod.DELETE)
	public String setDelete(Criteria cri, @PathVariable("gno") long gno) {
		galleryService.setDelete(gno);
		return "redirect:/gallery";
	}
	
	@RequestMapping(value = "/uploadAjax", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<GalleryDTO> uploadAjax(MultipartFile[] uploadFile) {
		GalleryDTO dto = new GalleryDTO();
		String uploadFolderPath = getFolder();
		uploadFolderPath.replaceAll("\\\\", "/");
		log.info(uploadFolderPath);
		dto.setUploadPath(uploadFolderPath);
		for (MultipartFile multipartFile : uploadFile) {
			log.info("----------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File size: " + multipartFile.getSize());
			//인터넷 익스플로러를 위한 파일 이름 처리
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			dto.setFileName(uploadFileName);
			UUID uuid = UUID.randomUUID();
			dto.setUuid(uuid.toString());
			uploadFileName = uuid.toString() + "_" + 	uploadFileName;	
			
			service.uploadFile(multipartFile, uploadFolderPath + "/" + uploadFileName);
			service.uploadThumbFile(multipartFile, uploadFolderPath + "/s_" + uploadFileName);
			
		}//end for
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/deleteAjax", method=RequestMethod.POST,  produces={MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String uuid, String uploadPath) {
		String temp = uploadPath + "/" + uuid + "_" + fileName;
		log.info(temp);
		service.fileDelete(temp);
		temp = uploadPath + "/s_" + uuid + "_" + fileName;
		log.info(temp);
		service.fileDelete(temp);
		return new ResponseEntity<>("사진이 삭제되었습니다.!", HttpStatus.OK);
	}

	
	
}
