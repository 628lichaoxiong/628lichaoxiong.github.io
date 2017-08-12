package com.transn.houtai.util;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 根据卡状态值，设置对应的描述
 * @author james.li
 * @time  2017年3月10日 上午10:57:03
 */
public class CardStatusTag extends TagSupport {
	private static final long serialVersionUID = -2312310581852395045L;
	private Integer value;

	@Override
	public int doStartTag() throws JspException {
		try {
			String respon=StatusMap.getType(value);
			pageContext.getOut().write(respon);
		} catch (IOException e) {
				e.printStackTrace();
		}
		return super.doStartTag();
	}

	public void setValue(Integer value) {
		this.value = value;
	}
}