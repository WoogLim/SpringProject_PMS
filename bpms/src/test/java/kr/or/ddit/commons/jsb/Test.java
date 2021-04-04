package kr.or.ddit.commons.jsb;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Test {
	public static void main(String[] args) throws Exception {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String startDate = sdf.format(cal.getTime());
		System.out.println(startDate);
		cal.add(Calendar.DATE, -7);
		String endDate = sdf.format(cal.getTime());
		System.out.println(endDate);
	}
}
