pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
t=0q=2
::_::t+=1
flip()for y=0,127do
d=128c=0
for i=t\q,t\q+15do
srand(i)
e=max(abs(t-i*q),abs(y-rnd(172)+32)*2)
if(e<d)d,c=e,rnd(5)
end
pset(127,y,c)
end
poke(0x5f54,0x60)spr(0,-1,0,16,16)palt(0b1011111111111111)pal(1,7)spr(0,-2,-12,16,16)pal()
goto _
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
