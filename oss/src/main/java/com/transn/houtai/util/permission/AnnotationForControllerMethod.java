package com.transn.houtai.util.permission;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Action的方法注解
 * 通过Java Annotation来识别该方法对应的功能号
 * @author james.li
 * @time  2017年3月23日 下午3:38:21
 */
@Retention( RetentionPolicy.RUNTIME)
@Target( ElementType.METHOD)
public @interface AnnotationForControllerMethod
{
  String funcCode(); // 功能编号，例如updateData对应的是UPDATE，selectAll对应的是SELECT
  int menuCode() default 0;
  String pageState() default ""; // 页面状态，定义返回后的
}
