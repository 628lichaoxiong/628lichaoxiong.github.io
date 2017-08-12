package com.transn.houtai.util.permission;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Action的方法注解
 * 是对AnnotationForControllerMethod的补充。有些controller的方法可能需要服用，
 * 即多个菜单的功能都复用这一个函数。
 * @author james.li
 * @time  2017年3月23日 下午3:38:57
 */
@Retention( RetentionPolicy.RUNTIME)
@Target( ElementType.METHOD)
public @interface PrivateAppend
{
  String menuFuncs(); // 例如 1203:SELECT,9809:UPDATE
}
