package com.transn.houtai.util.permission;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * 通过Java Annotation来识别 
 * 1：Action中的菜单号menuCode； 
 * @author james.li
 * @time  2017年3月23日 下午3:38:06
 */
@Retention( RetentionPolicy.RUNTIME)
@Target( ElementType.TYPE)
public @interface AnnotationForController
{
  int menuCode(); // 菜单功能号
}
