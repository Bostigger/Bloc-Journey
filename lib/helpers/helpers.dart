String formatTime(int secs, bool pad){
  return (pad)
      ?"${(secs/60).floor()}:${(secs%60).toString().padLeft(2,"0")}":
  (secs>59)?"${(secs/60).floor()}:${(secs%60).toString().padLeft(2,"0")}":
  secs.toString();
}