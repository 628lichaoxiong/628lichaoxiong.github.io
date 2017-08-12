package com.transn.houtai.util;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 根据参数获取系统状态名称
 * @author james.li
 * @time  2017年7月19日 上午10:57:03
 */
public class StatusNameTag extends TagSupport {
	private static final long serialVersionUID = -2312310581852395045L;
	private String value;

	@Override
	public int doStartTag() throws JspException {
		try {
			String respon =RedisUtils.get(RedisValue.SystemStatusName+value);
			pageContext.getOut().write(respon);
		} catch (IOException e) {
				e.printStackTrace();
		}
		return super.doStartTag();
	}

	public void setValue(String value) {
		this.value = value;
	}
}