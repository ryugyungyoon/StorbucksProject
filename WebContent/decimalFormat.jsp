<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.text.DecimalFormat" %>
<%!
public static String withCommas(int number){
	DecimalFormat df = new DecimalFormat("###,###,###");
	return	df.format(number);
}
%>
