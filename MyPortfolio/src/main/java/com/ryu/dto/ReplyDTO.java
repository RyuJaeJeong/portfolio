package com.ryu.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {
	private long no;
	private long board_no;
	private String reply;
	private String replyer;
	private Date replyDate;
}
