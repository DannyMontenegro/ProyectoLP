int getDiffYMD(DateTime then, DateTime now) {
  int years = now.year - then.year;
  int months = now.month - then.month;
  int days = now.day - then.day;
  if (months < 0 || (months == 0 && days < 0)) {
    years--;
    months += (days < 0 ? 11 : 12);
  }
  if (days < 0) {
    final monthAgo = DateTime(now.year, now.month - 1, then.day);
    days = now.difference(monthAgo).inDays + 1;
  }
  return months + years * 12;
  
}
