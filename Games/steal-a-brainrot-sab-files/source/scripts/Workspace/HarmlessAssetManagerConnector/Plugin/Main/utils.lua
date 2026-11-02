local a={}local b=require(script.Parent.Parent.lib.zzlib)function a.
normalise_asset_id(c:any):string local d=tostring(c)d=d:match'^%s*(.-)%s*$'d=d:
gsub('rbxassetid://','')local e=d:match'id=(%d+)'if e then d=e end d=d:gsub(
'[^0-9]','')if#d<7 or#d>18 then return''end if d:sub(-5)=='00000'or d:sub(-5)==
'99999'or d:sub(1,1)=='0'then return''end return d end function a.
pullScriptAssets(c:Instance):{}local d={}local e=c.Parent:GetFullName()if e:sub(
1,19)=='PluginDebugService.'then return d end local f=''if not(c:IsA'Script'or c
:IsA'LocalScript'or c:IsA'ModuleScript')then return d end f=c.Source if not
string.find(f:lower(),'rbxassetid')and not string.find(f:lower(),'sound')and not
string.find(f:lower(),'animation')then return d end for g in string.gmatch(f,
'%f[%d](%d+)%f[%D]')do if#g<7 or#g>18 then continue end if g:sub(-5)=='00000'or
g:sub(-5)=='99999'or g:sub(1,1)=='0'then continue end table.insert(d,a.
normalise_asset_id(g))end return d end function a.base64Decode(c:string):string
local d=[[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/]]
local e=''for f=1,#c,4 do local g={c:sub(f,f),c:sub(f+1,f+1),c:sub(f+2,f+2),c:
sub(f+3,f+3)}local h=0 for i,j in ipairs(g)do if j~='='then local k=d:find(j,1,
true)if k then h=h*64+(k-1)end else h=h*64 end end if g[3]=='='then e=e..string.
char(bit32.rshift(h,16))elseif g[4]=='='then e=e..string.char(bit32.rshift(h,16)
)..string.char(bit32.band(bit32.rshift(h,8),0xff))else e=e..string.char(bit32.
rshift(h,16))..string.char(bit32.band(bit32.rshift(h,8),0xff))..string.char(
bit32.band(h,0xff))end end return e end function a.gzipDecompress(c:string):(
boolean,string)local d,e=pcall(function()local d=b.gunzip(c)return d end)return
d,e end function a.calculateGameIdentity():string local c=game.PlaceId or 0
local d=game:GetAttribute'HAMGameUUID'or'unknown'return`{c}_{d}`end function a.
runWithTimeout(c,d)local e=false local f,g task.spawn(function()f,g=pcall(c)e=
true end)local h=os.clock()while not e and os.clock()-h<d do task.wait()end if
not e then return false,'HTTP request timed out'end return f,g end return a