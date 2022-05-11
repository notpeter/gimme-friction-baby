function reset()
{
   bgsound.stop();
   restore();
}
function quit()
{
   GameManager.getInstance().gameDone();
}
function shooter()
{
   onMouseDown = function()
   {
      shootnow();
   };
   if(l.deg == 360 || l.deg == 180)
   {
      l.mov *= -1;
   }
   l.deg += l.mov;
   var rad = l.deg * 0.017453292519943295;
   b.lx = Math.cos(rad) * 60 + 320;
   b.ly = Math.sin(rad) * 60 + 450;
   with(l)
   {
      clear();
      lineStyle(0,16777215,0);
      moveTo(320,450);
      lineTo(b.lx,b.ly);
   }
   arro._x = b.lx;
   arro._y = b.ly;
   var dx = b._x - b.lx;
   var dy = b._y - b.ly;
   var rad = Math.atan2(dy,dx);
   var deg = rad * 57.29577951308232;
   arro._rotation = deg - 90;
}
function newball()
{
   i++;
   b = cont.attachMovie("ball","ball" + i,i);
   b._x = 320;
   b._y = 450;
   b.r = 10;
   b.vx = 0;
   b.vy = 0;
   b.m = 1;
   b.f = 1;
   b.gotoAndStop(b.f);
   b._rotation = random(30) - 15;
   barray.push(b);
}
function shootnow()
{
   if(firstshot == false)
   {
      firstshot = true;
      tscreen.onEnterFrame = function()
      {
         this._alpha -= 1;
         if(this._alpha < 10)
         {
            delete this.onEnterFrame;
            this.removeMovieClip();
         }
      };
   }
   if(fsm == shooter && _xmouse < 520 && _xmouse > 120)
   {
      shootsound.start(0.01,1);
      b.vx = (- (b.lx - 320)) / 4;
      b.vy = (- (b.ly - 450)) / 4;
      fsm = moveball;
      onMouseDown = function()
      {
      };
      with(l)
      {
         clear();
      }
   }
}
function nothing()
{
}
function moveball()
{
   findn();
   b.vx *= friction;
   b.vy *= friction;
   if(b._x - b.vx < 130 || b._x - b.vx > 510)
   {
      b.vx *= -1;
      wallsound.start(0.01,1);
   }
   if(b._y - b.vy < 15)
   {
      b.vy *= -1;
      wallsound.start(0.01,1);
   }
   b._x -= b.vx;
   b._y -= b.vy;
   if(b.vy < 0 && b._y + b.r > 395)
   {
      bgsound.stop();
      createexp(b);
      b.removeMovieClip();
      goscreen = _root.attachMovie("goscreen","goscreen",29000);
      goscreen._x = 320;
      goscreen._y = -100;
      fsm = gomove;
      onMouseDown = function()
      {
         restore();
      };
   }
   if(Math.abs(b.vx) + Math.abs(b.vy) < 0.2)
   {
      calc();
      b.m = 100000;
      b.vx = 0;
      b.vy = 0;
      news = nd / b.r * 100;
      fsm = grow2;
   }
}
function findn()
{
   p = 0;
   while(p < barray.length - 1)
   {
      var _loc2_ = b._x - b.vx - barray[p]._x;
      var _loc1_ = b._y - b.vy - barray[p]._y;
      var _loc3_ = Math.sqrt(_loc2_ * _loc2_ + _loc1_ * _loc1_) - barray[p].r;
      if(_loc3_ < nd)
      {
         nd = _loc3_;
         n = p;
      }
      p++;
   }
   checkColl(b,barray[n]);
   n = -1;
   nd = 10000;
}
function calc()
{
   p = 0;
   while(p < barray.length - 1)
   {
      var _loc2_ = b._x - barray[p]._x;
      var _loc1_ = b._y - barray[p]._y;
      var _loc3_ = Math.sqrt(_loc2_ * _loc2_ + _loc1_ * _loc1_) - barray[p].r;
      if(_loc3_ < nd)
      {
         n = p;
         nd = _loc3_;
      }
      p++;
   }
   if(b._x - 120 < nd)
   {
      nd = b._x - 120;
      wall = true;
   }
   if(520 - b._x < nd)
   {
      nd = 520 - b._x;
      wall = true;
   }
   if(b._y - 5 < nd)
   {
      nd = b._y - 5;
      wall = true;
   }
   if(395 - b._y < nd)
   {
      nd = 395 - b._y;
      wall = true;
   }
}
function grow2()
{
   var _loc1_ = news - b._xscale;
   b._xscale += _loc1_ / 5;
   b._yscale += _loc1_ / 5;
   if(_loc1_ < 10)
   {
      b._xscale = b._yscale = news;
      b.cacheAsBitmap = true;
      b.r = nd;
      newball();
      fsm = shooter;
      nd = 10000;
      n = -1;
      wall = false;
   }
}
function checkColl(b1, b2)
{
   var _loc7_ = b2._x - b1._x;
   var _loc6_ = b2._y - b1._y;
   var _loc5_ = Math.sqrt(_loc7_ * _loc7_ + _loc6_ * _loc6_);
   if(_loc5_ < b1.r + b2.r)
   {
      var _loc8_ = _loc5_ - (b1.r + b2.r);
      var _loc12_ = _loc7_ / _loc5_;
      var _loc11_ = _loc6_ / _loc5_;
      b1._x += _loc8_ * _loc12_;
      b1._y += _loc8_ * _loc11_;
      b2.f = b2.f + 1;
      if(b2.f == 4)
      {
         zero = _root.attachMovie("zero","zero",_root.getNextHighestDepth());
         zero._x = b2._x;
         zero._y = b2._y;
         zero._xscale = zero._yscale = b2._xscale;
         zero._rotation = b2._rotation;
         _loc12_ = _loc7_ / _loc5_;
         _loc11_ = _loc6_ / _loc5_;
         var _loc9_ = Math.sqrt(b.vx * b.vx + b.vy * b.vy);
         zero.vx = _loc12_ * _loc9_;
         zero.vy = _loc11_ * _loc9_;
         zero.rot = Math.random() * 4 - 2;
         zero.onEnterFrame = function()
         {
            this.vy += 0.2;
            this._x += this.vx;
            this._y += this.vy;
            this._rotation += this.rot;
            if(this._y > 1000)
            {
               delete this.onEnterFrame;
               this.removeMovieClip();
            }
         };
         score++;
         sco.text = score;
         if(score > hisco.text)
         {
            so.data.hi = score;
            so.flush();
            hisco.text = score;
         }
      }
      var _loc10_ = Math.atan2(_loc6_,_loc7_);
      cosa = Math.cos(_loc10_);
      sina = Math.sin(_loc10_);
      vx1p = cosa * b1.vx + sina * b1.vy;
      vy1p = cosa * b1.vy - sina * b1.vx;
      vx2p = cosa * b2.vx + sina * b2.vy;
      vy2p = cosa * b2.vy - sina * b2.vx;
      P = vx1p * b1.m + vx2p * b2.m;
      V = vx1p - vx2p;
      vx1p = (P - b2.m * V) / (b1.m + b2.m);
      vx2p = V + vx1p;
      b1.vx = cosa * vx1p - sina * vy1p;
      b1.vy = cosa * vy1p + sina * vx1p;
      diff = (b1.r + b2.r - _loc5_) / 2;
      cosd = cosa * diff;
      sind = sina * diff;
      if(b2.f == 4)
      {
         createexp(b2);
         b2.removeMovieClip();
         barray.splice(n,1);
         return undefined;
      }
      b2.gotoAndStop(b2.f);
      createpart(b1,b2);
   }
}
function createpart(b1, b2)
{
   cracksound.start(0.01,1);
   var _loc8_ = b2._x - b1._x;
   var _loc7_ = b2._y - b1._y;
   var _loc6_ = Math.atan2(_loc7_,_loc8_);
   var _loc4_ = Math.cos(_loc6_) * b1.r + b1._x;
   var _loc3_ = Math.sin(_loc6_) * b1.r + b1._y;
   pc = 0;
   while(pc < 10)
   {
      part = _root.attachMovie("part","part",_root.getNextHighestDepth());
      part._x = _loc4_;
      part._y = _loc3_;
      part.vx = Math.random() * 10 - 5;
      part.vy = Math.random() * 10 - 5;
      part.gotoAndStop(random(2) + 1);
      part.onEnterFrame = function()
      {
         this.vy += 0.1;
         this._x += this.vx;
         this._y += this.vy;
         this._alpha -= 1;
         if(this._alpha < 10)
         {
            delete this.onEnterFrame;
            this.removeMovieClip();
         }
      };
      pc++;
   }
}
function createexp(b2)
{
   cracksound.start(0.01,1);
   pc = 0;
   while(pc < 20)
   {
      cut = _root.createEmptyMovieClip("cut",_root.getNextHighestDepth());
      with(cut)
      {
         lineStyle(0,0,0);
         beginFill(16777215,100);
         lineTo(random(30) - 15,random(30) - 15);
         lineTo(random(30) - 15,random(30) - 15);
         endFill();
      }
      cut._x = b2._x;
      cut._y = b2._y;
      cut.vx = Math.random() * 16 - 8;
      cut.vy = Math.random() * 16 - 8;
      cut.rotspeed = Math.random(6) - 3;
      cut.onEnterFrame = function()
      {
         this._x += this.vx;
         this._y += this.vy;
         this._rotation += this.rotspeed;
         this._alpha -= 0.5;
         if(this._alpha < 1)
         {
            delete this.onEnterFrame;
            this.removeMovieClip();
         }
      };
      pc++;
   }
}
function gomove()
{
   goscreen._y -= (goscreen._y - 240) / 10;
}
function restore()
{
   score = 0;
   sco.text = score;
   goscreen.removeMovieClip();
   i = 0;
   while(i < barray.length)
   {
      barray[i].removeMovieClip();
      i++;
   }
   barray = [];
   i = 10;
   n = -1;
   nd = 10000;
   wall = false;
   news = 0;
   fsm = shooter;
   newball();
   bgsound.start(0.01,9999);
   onMouseDown = function()
   {
      shootnow();
   };
}
MovieClip.prototype.useHandCursor = false;
so = SharedObject.getLocal("hiscore");
_root.createEmptyMovieClip("bgsoundholder",1);
bgsound = new Sound(bgsoundholder);
bgsound.attachSound("sound1");
bgsound.start(0.01,9999);
bgsound.setVolume(50);
_root.createEmptyMovieClip("effectsoundholder",2);
cracksound = new Sound(effectsoundholder);
cracksound.attachSound("sound2");
shootsound = new Sound(effectsoundholder);
shootsound.attachSound("sound3");
wallsound = new Sound(effectsoundholder);
wallsound.attachSound("sound4");
fsm = shooter;
var score = 0;
sco.text = score;
if(so.data.hi == undefined)
{
   hisco.text = 0;
}
else
{
   hisco.text = so.data.hi;
}
var i = 10;
var friction = 0.975;
var n = -1;
var nd = 10000;
var wall = false;
var news = 0;
var barray = new Array();
var firstshot = false;
cont = _root.createEmptyMovieClip("cont",10);
l = cont.createEmptyMovieClip("l",2);
l.deg = 182;
l.mov = 2;
statief = _root.attachMovie("statief","statief",40000);
statief._x = 320;
statief._y = 395;
arro = _root.attachMovie("arrow","arrow",30000);
tscreen = _root.attachMovie("titlescreen","titlescreen",10000);
tscreen._x = 320;
tscreen._y = 200;
onMouseDown = function()
{
   shootnow();
};
_root.onEnterFrame = function()
{
   fsm();
};
newball();
stop();
