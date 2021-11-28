package com.ryu.dto;

import lombok.Data;

@Data
public class GalleryDTO {
	
	//filed
	private long gno;
	private String title;
	private String writer;
	private String comments;
	private String uploadPath;
	private String uuid;
	private String fileName;
	private String totalUri;
}
