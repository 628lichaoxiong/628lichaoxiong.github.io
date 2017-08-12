package com.transn.houtai.util;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 根据菜单编号获取菜单名称
 * @author james.li
 * @time  2017年3月10日 上午10:57:03
 */
public class MenuNameTag extends TagSupport {
	private static final long serialVersionUID = -2312310581852395045L;
	private Integer value;

	@Override
	public int doStartTag() throws JspException {
		try {
			String respon =RedisUtils.get(RedisValue.SysFirstMenusName+RedisValue.SplitIdAndName+value);
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