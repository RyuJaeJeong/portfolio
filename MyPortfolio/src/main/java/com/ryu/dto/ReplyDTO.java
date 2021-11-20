package com.ryu.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {
	private long rno;
	private long bno;
	private String reply;
	private String replyer;
	private Date replyDate;
}
