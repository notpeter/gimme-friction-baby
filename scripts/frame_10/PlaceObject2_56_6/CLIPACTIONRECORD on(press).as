on(press){
   if(_root.bgsound.getVolume() == 50)
   {
      _root.bgsound.setVolume(0);
      _root.cracksound.setVolume(0);
   }
   else
   {
      _root.bgsound.setVolume(50);
      _root.cracksound.setVolume(100);
   }
}
