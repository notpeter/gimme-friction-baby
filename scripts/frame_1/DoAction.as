stop();
bestands_grote = getBytesTotal();
onEnterFrame = function()
{
   al_geladen = getBytesLoaded();
   procent = Math.round(al_geladen / bestands_grote * 100);
   hoeveel_procent.text = procent + "%";
   laadbalk._xscale = procent;
   if(bestands_grote == al_geladen)
   {
      delete onEnterFrame;
      gotoAndPlay(9);
   }
};
