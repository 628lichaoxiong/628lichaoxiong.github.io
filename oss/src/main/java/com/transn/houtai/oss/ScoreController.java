package com.transn.houtai.oss;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/score")
public class ScoreController extends BaseController {
	Logger logger = LoggerFactory.getLogger(ScoreController.class);
	
}
