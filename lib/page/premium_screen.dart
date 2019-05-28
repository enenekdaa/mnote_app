import 'package:flutter/material.dart';

class PremiumScreen extends StatefulWidget {
  @override
  _PremiumScreenState createState() => new _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: FlatButton(
              onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            '프리미엄 구매',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey,
        ),
        backgroundColor: Colors.white,
        body:
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                "PC버전 이용",
                textAlign: TextAlign.center,
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                  "<(주) 아이커머>(‘http://www.icomer.com’이하 ‘첵첵’)은\n 개인정보를 다음의 목적을 위해 처리합니다. \n처리한개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용목적이 변경될 시에는 사전동의를 구할 예정입니다.\n "),
              Text(
                "가. 재화 또는 서비스 제공콘텐츠 제공 등을 목적으로 개인정보를 처리합니다.\n ",
                textAlign: TextAlign.start,
              ),
              Text(
                "2. 개인정보 파일 현황 \n ",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                  "1. 개인정보 파일명 : 구매 정보\n - 개인정보 항목 : 이메일\n - 수집방법 : 인앱 결제를 통한 스토어 계정 정보 수집\n - 보유근거 : 서비스의 원활한 이용\n - 보유기간 : 서비스 이용 완료시 지체없이 파기\n "),
              Text(
                "3. 개인정보처리 위탁 \n ",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                  "<(주) 아이커머>(‘첵첵’)은 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다."),
            ],
          ),
        )
    );
  }
}