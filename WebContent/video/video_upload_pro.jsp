<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.DB_Connector"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
	request.setCharacterEncoding("UTF-8");

	// 파일이 저장될 위치
	// String path = "C:\\upload\\";
	String path = pageContext.getServletContext().getRealPath("/")
			+ "video_file\\";
	String url = request.getContextPath();

	String path2 = request.getContextPath();

	// 파일 용량 제한
	int max = 1024 * 1024 * 10; // 10MB
	// 파일 인코딩
	String enc = "utf-8";

	// 중복 파일명을 위한 파일명 정책 객체
	DefaultFileRenamePolicy dfr = new DefaultFileRenamePolicy();

	// 업로드 처리
	MultipartRequest mr = new MultipartRequest(request, path, max, enc,
			dfr);

	// 원본 파일 이름
	String oName = mr.getOriginalFileName("data");

	// 서버에서의 파일 이름(이걸 데이터베이스에 넣어주세요)
	String sName = mr.getFilesystemName("data");

	Enumeration formNames = mr.getFileNames(); // 폼의 이름 반환

	String fileInput = "";
	String fileName = "";
	String type = "";
	File fileObj = null;
	String fileExtend = "";
	String fileSize = "";
	String fileTime = "";

	while (formNames.hasMoreElements()) {
		fileInput = (String) formNames.nextElement(); // 파일인풋 이름
		if (fileName != null) {
			type = mr.getContentType(fileInput); //콘텐트타입    
			fileObj = mr.getFile(fileInput); //파일객체
			fileExtend = fileName.substring(fileName.lastIndexOf(".") + 1); //파일 확장자
			fileSize = String.valueOf(fileObj.length()); // 파일크기
		}
	}

	
	String video_title = mr.getParameter("video_title");
	String subject_idx = mr.getParameter("subject");
	String video_content = mr.getParameter("video_content");
	fileTime = mr.getParameter("video_time");
	fileTime = fileTime.split("\\.")[0];
	
	

	// DB
	Connection conn = DB_Connector.getConnection();

	// 동영상 인덱스(video_seq), 동영상 제목(video_title), 원본 파일 이름(oName), 저장 파일 이름(sName), 강의 길이, 
	// 파일 경로, 파일 사이즈, 올린 날짜, 조회수, 과목 인덱스, 과목별 인덱스

	String sql = null;
	
	if(subject_idx.equals("1")){
		// 정보처리기사
		sql = "insert into video values("
			+ "video_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, subject1_seq.nextval, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, video_title);
		pstmt.setString(2, oName);
		pstmt.setString(3, sName);
		pstmt.setString(4, fileTime);
		pstmt.setString(5, path2 + "/video_file/" + sName);
		pstmt.setString(6, fileSize);
		// sysdate
		pstmt.setInt(7, 0); // 조회수
		pstmt.setString(8, subject_idx);
		pstmt.setString(9, video_content);
		pstmt.execute();
		out.print("1 입력 완료 <br />");
	} else if(subject_idx.equals("2")){
		// 전산세무 2급
		sql = "insert into video values("
			+ "video_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, subject2_seq.nextval, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, video_title);
		pstmt.setString(2, oName);
		pstmt.setString(3, sName);
		pstmt.setString(4, fileTime);
		pstmt.setString(5, path2 + "/video_file/" + sName);
		pstmt.setString(6, fileSize);
		// sysdate
		pstmt.setInt(7, 0); // 조회수
		pstmt.setString(8, subject_idx);
		pstmt.setString(9, video_content);
		pstmt.execute();
		out.print("2 입력 완료 <br />");
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비디오 데이터 확인</title>
</head>
<body>
	원본파일 이름 : <%=oName%>
	<br />
	서버에서의 이름 : <%=sName%>
	<br />
	파일 사이즈 : <%=fileSize%>
	<br />
	콘텐트 타입 : <%=fileName%>
	<br />
	파일 확장자 : <%=fileExtend%>
	<br />
	파일 시간 : <%=fileTime%>
	<br />
	real path : <%=path%>
	<br />
	select : <%=subject_idx%>
	<br />
	video_title : <%=video_title %>
	<br />
	video_content : <%=video_content %>
	<br />
	<br />
	<video src="<%=path2%>/video_file/<%=sName%>" controls="controls"></video>
	<br />
	<br />
	<a href="<%=path2%>/video/all_video.jsp">화면으로</a>
</body>
</html>