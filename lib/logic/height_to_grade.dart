  String getGrade(double heightMeter) {
    if (heightMeter < 200) return "仮入部級！";
    if (heightMeter < 500) return "新人部員級！";
    if (heightMeter < 2483) return "日吉代表級！";
    if (heightMeter < 3776) return "総代表級！";
    if (heightMeter < 8848) return "名誉代表級！";
    return "LEGEND OB級！";
  }