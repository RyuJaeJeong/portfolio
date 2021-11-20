package com.ryu.dto;

import java.util.Date;
import java.util.List;
import lombok.Data;


@Data
public class MemberDTO {
	private long mno;
	private String userid;
	private String userpw;
	private String userName;
	private boolean enabled;
	private Date regiDate;
	private List<AuthDTO> authList;
}
