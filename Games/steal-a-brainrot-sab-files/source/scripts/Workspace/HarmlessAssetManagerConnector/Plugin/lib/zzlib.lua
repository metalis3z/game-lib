local a=require(script.inflatebit32)type BitStream=a.BitStream local b={}
local function arraytostr(c:{number})local d={}local e=#c local f=1 local g=1
while e>0 do local h=e>=2048 and 2048 or e local i=string.char(unpack(c,f,f+h-1)
)f=f+h e=e-h local j=1 while d[j]do i=d[j]..i d[j]=nil j=j+1 end if j>g then g=j
end d[j]=i end local h=''for i=1,g do if d[i]then h=d[i]..h end end return h end
local function inflate_gzip(c:BitStream)local d,e,f,g=c.buf:byte(1,4)if d~=31 or
e~=139 then error'invalid gzip header'end if f~=8 then error
'only deflate format is supported'end c.pos=11 if bit32.band(g,4)~=0 then local
h,i=c.buf:byte(c.pos,c.pos+1)local j=i*256+h c.pos=c.pos+j+2 end if bit32.band(g
,8)~=0 then local h=c.buf:find('\0',c.pos)c.pos=h+1 end if bit32.band(g,16)~=0
then local h=c.buf:find('\0',c.pos)c.pos=h+1 end if bit32.band(g,2)~=0 then c.
pos=c.pos+2 end local h=arraytostr(a.main(c))local i=c:getb(8)+256*(c:getb(8)+
256*(c:getb(8)+256*c:getb(8)))if i~=a.crc32(h)then error
'checksum verification failed'end return h end local function adler32(c:string)
local d=1 local e=0 for f=1,#c do local g=c:byte(f)d=(d+g)%65521 e=(e+d)%65521
end return e*65536+d end local function inflate_zlib(c:BitStream)local d=c.buf:
byte(1)local e=c.buf:byte(2)if(d*256+e)%31~=0 then error
'zlib header check bits are incorrect'end if bit32.band(d,15)~=8 then error
'only deflate format is supported'end if bit32.rshift(d,4)~=7 then error
'unsupported window size'end if bit32.band(e,32)~=0 then error
'preset dictionary not implemented'end c.pos=3 local f=arraytostr(a.main(c))
local g=((c:getb(8)*256+c:getb(8))*256+c:getb(8))*256+c:getb(8)if g~=adler32(f)
then error'checksum verification failed'end return f end local function
inflate_raw(c:string,d:number,e:number?)local f=a.bitstream_init(c)f.pos=d local
g=arraytostr(a.main(f))if e and e~=a.crc32(g)then error
'checksum verification failed'end return g end function b.gunzip(c)return
inflate_gzip(a.bitstream_init(c))end function b.inflate(c)return inflate_zlib(a.
bitstream_init(c))end local function int2le(c,d)local e,f=c:byte(d,d+1)return f*
256+e end local function int4le(c,d)local e,f,g,h=c:byte(d,d+3)return((h*256+g)*
256+f)*256+e end local function nextfile(c,d)if int4le(c,d)~=0x2014b50 then
return end local e=int2le(c,d+10)~=0 local f=int4le(c,d+16)local g=int2le(c,d+28
)local h=c:sub(d+46,d+45+g)local i=int4le(c,d+42)+1 d=d+46+g+int2le(c,d+30)+
int2le(c,d+32)if int4le(c,i)~=0x4034b50 then error
'invalid local header signature'end local j=int4le(c,i+18)local k=int2le(c,i+28)
i=i+30+g+k return d,h,i,j,e,f end function b.files(c:string)local d=#c-21 if
int4le(c,d)~=0x6054b50 then error'.ZIP file comments not supported'end local e=
int4le(c,d+16)+1 return nextfile,c,e end function b.unzip(c:string,d:(string|
number),e:number?)if type(d)=='number'then return inflate_raw(c,d,e)else local f
=d for g,h,i,j,k,l in b.files(c)do if h==f then local m if not k then m=c:sub(i,
i+j-1)else m=inflate_raw(c,i,l)end return m end end error("file '"..f..
"' not found in ZIP archive")end end return b