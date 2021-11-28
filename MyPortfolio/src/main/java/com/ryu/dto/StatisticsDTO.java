package com.ryu.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class StatisticsDTO {
	private long sno;
	private long board; 
	private long member;
	private long gallery;
	private Date regidate;
	private String regdate;
}
