<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
</head>
<body>
<!-- ���̹����̵�ηα��� ��ư ���� ���� -->
<div id="naverIdLogin"></div>
<!-- //���̹����̵�ηα��� ��ư ���� ���� -->

<!-- ���̹��Ƶ��ηα��� �ʱ�ȭ Script -->
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "4tT_eUsoS5xWKizbZwxT",
			callbackUrl: "http://localhost:8080/assistant/loginCallback.do",
			isPopup: false, /* �˾��� ���� ����ó�� ���� */
			loginButton: {color: "green", type: 3, height: 60} /* �α��� ��ư�� Ÿ���� ���� */
		}
	);
	
	/* ���������� �ʱ�ȭ�ϰ� ������ �غ� */
	naverLogin.init();
	
</script>
<!-- // ���̹����̵�ηα��� �ʱ�ȭ Script -->
</body>
</html>