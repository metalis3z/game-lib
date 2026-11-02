local a={}export type BitStream={buf:string,len:number,pos:number,b:number,n:
number,flushb:(self:BitStream,number)->(),peekb:(self:BitStream,number)->(number
),getb:(self:BitStream,number)->(number),getv:(self:BitStream,{number},number)->
(number)}function a.bitstream_init(b)local c:BitStream={buf='',len=0,pos=1,b=0,n
=0,flushb=function(c,d)c.n=c.n-d c.b=bit32.rshift(c.b,d)end,peekb=function(c,d)
while c.n<d do if c.pos>c.len then c.len=c.buf:len()c.pos=1 end c.b=c.b+bit32.
lshift(c.buf:byte(c.pos),c.n)c.pos=c.pos+1 c.n=c.n+8 end return bit32.band(c.b,
bit32.lshift(1,d)-1)end,getb=function(c,d)local e=c:peekb(d)c.n=c.n-d c.b=bit32.
rshift(c.b,d)return e end,getv=function(c,d,e)local f=d[c:peekb(e)]local g=bit32
.band(f,15)local h=bit32.rshift(f,4)c.n=c.n-g c.b=bit32.rshift(c.b,g)return h
end}c.buf=b c.len=c.buf:len()return c end local function hufftable_create(b:{
number}):({number},number)local c=#b local d=1 local e={}local f={}for g=1,c do
local h=b[g]if h>d then d=h end e[h]=(e[h]or 0)+1 end local g={}local h=0 e[0]=0
for i=1,d do h=(h+(e[i-1]or 0))*2 f[i]=h end for i=1,c do local j=b[i]or 0 if j>
0 then local k=(i-1)*16+j local l=f[j]local m=0 for n=1,j do m=m+bit32.lshift(
bit32.band(1,bit32.rshift(l,n-1)),j-n)end for n=0,2^d-1,2^j do g[n+m]=k end f[j]
=f[j]+1 end end return g,d end local function block_loop(b:{number},c:BitStream,
d:number,e:number,f:{number},g:{number})local h repeat h=c:getv(f,d)if h<256
then table.insert(b,h)elseif h>256 then local i=0 local j=3 local k=1 if h<265
then j=j+h-257 elseif h<285 then i=bit32.rshift(h-261,2)j=j+bit32.lshift(bit32.
band(h-261,3)+4,i)else j=258 end if i>0 then j=j+c:getb(i)end local l=c:getv(g,e
)if l<4 then k=k+l else i=bit32.rshift(l-2,1)k=k+bit32.lshift(bit32.band(l,1)+2,
i)k=k+c:getb(i)end local m=#b-k+1 while j>0 do table.insert(b,b[m])m=m+1 j=j-1
end end until h==256 end local function block_dynamic(b:{number},c:BitStream)
local d={17,18,19,1,9,8,10,7,11,6,12,5,13,4,14,3,15,2,16}local e=257+c:getb(5)
local f=1+c:getb(5)local g=4+c:getb(4)local h={}for i=1,g do local j=c:getb(3)h[
d[i] ]=j end for i=g+1,19 do h[d[i] ]=0 end local i,j=hufftable_create(h)local k
=1 while k<=e+f do local l=c:getv(i,j)if l<16 then h[k]=l k=k+1 elseif l<19 then
local m={2,3,7}local n=m[l-15]local o=0 local p=3+c:getb(n)if l==16 then o=h[k-1
]elseif l==18 then p=p+8 end for q=1,p do h[k]=o k=k+1 end else error(
'wrong entry in depth table for literal/length alphabet: '..l)end end local l={}
for m=1,e do table.insert(l,h[m])end local m,n=hufftable_create(l)local o={}for
p=e+1,#h do table.insert(o,h[p])end local p,q=hufftable_create(o)block_loop(b,c,
n,q,m,p)end local function block_static(b:{number},c:BitStream)local d={144,112,
24,8}local e={8,9,7,8}local f={}for g=1,4 do local h=e[g]for i=1,d[g]do table.
insert(f,h)end end local g,h=hufftable_create(f)f={}for i=1,32 do f[i]=5 end
local i,j=hufftable_create(f)block_loop(b,c,h,j,g,i)end local function
block_uncompressed(b:{number},c:BitStream)c:flushb(bit32.band(c.n,7))local d=c:
getb(16)if c.n>0 then error
'Unexpected.. should be zero remaining bits in buffer.'end local e=c:getb(16)if
bit32.bxor(d,e)~=65535 then error"LEN and NLEN don't match"end for f=c.pos,c.pos
+d-1 do table.insert(b,c.buf:byte(f,f))end c.pos=c.pos+d end function a.main(b:
BitStream):{number}local c,d local e={}repeat c=b:getb(1)d=b:getb(2)if d==0 then
block_uncompressed(e,b)elseif d==1 then block_static(e,b)elseif d==2 then
block_dynamic(e,b)else error'unsupported block type'end until c==1 b:flushb(
bit32.band(b.n,7))return e end local b:{[number]:number}={}function a.crc32(c:
string):number if b[0]==nil then b={}for d=0,255 do local e=d for f=1,8 do e=
bit32.bxor(bit32.rshift(e,1),bit32.band(0xedb88320,bit32.bnot(bit32.band(e,1)-1)
))end b[d]=e end end local d=bit32.bnot(0)for e=1,#c do local f=c:byte(e)d=bit32
.bxor(b[bit32.bxor(f,bit32.band(d,0xff))],bit32.rshift(d,8))end d=bit32.bnot(d)
if d<0 then d=d+4294967296 end return d end return a