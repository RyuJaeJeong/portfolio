package com.ryu.dto;

import java.sql.Date;

import lombok.Data;

//data 어노테이션은 자동으로 getter&setter 와 toString을 생성한다. 

@Data
public class BoardDTO {
	
	//field 
	private long rownum;
	private long bno;
	private String title;
	private String writer;
	private String content;
	private Date regidate;
	private int replyCnt;
	private long mgr;
	private int level;
}
