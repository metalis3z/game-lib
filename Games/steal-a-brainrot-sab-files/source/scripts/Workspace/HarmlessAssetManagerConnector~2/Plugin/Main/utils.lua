local a={}local b=game:GetService'EncodingService'local c=require(script.Parent.
Parent.lib.zzlib)function a.normalise_asset_id(d:any):string local e=tostring(d)
e=e:match'^%s*(.-)%s*$'e=e:gsub('rbxassetid://','')local f=e:match'id=(%d+)'if f
then e=f end e=e:gsub('[^0-9]','')if#e<7 or#e>18 then return''end if e:sub(-5)==
'00000'or e:sub(-5)=='99999'or e:sub(1,1)=='0'then return''end return e end
function a.pullScriptAssets(d:Instance):{}local e={}local f=d.Parent:
GetFullName()if f:sub(1,19)=='PluginDebugService.'then return e end local g=''if
not(d:IsA'Script'or d:IsA'LocalScript'or d:IsA'ModuleScript')then return e end g
=d.Source local h={'rbxassetid','sound','animation','idle','run','walk','jump',
'emote','equip'}local i=false local j=g:lower()for k,l in ipairs(h)do if string.
find(j,l,1,true)then i=true break end end if not i then return e end for k in
string.gmatch(g,'%f[%d](%d+)%f[%D]')do if#k<7 or#k>18 then continue end if k:
sub(-5)=='00000'or k:sub(-5)=='99999'or k:sub(1,1)=='0'then continue end table.
insert(e,a.normalise_asset_id(k))end return e end function a.base64Decode(d:
string):string local e=buffer.fromstring(d)local f,g=pcall(function()return b:
Base64Decode(e)end)if not f then error('Base64 decoding failed: '..tostring(g))
return nil end return buffer.tostring(g)end function a.gzipDecompress(d:string):
(boolean,string)local e,f=pcall(function()local e=c.gunzip(d)return e end)return
e,f end function a.calculateGameIdentity():string local d=game.PlaceId or 0
local e=game:GetAttribute'HAMGameUUID'or'unknown'return`{d}_{e}`end function a.
runWithTimeout(d,e)local f=false local g,h task.spawn(function()g,h=pcall(d)f=
true end)local i=os.clock()while not f and os.clock()-i<e do task.wait()end if
not f then return false,'HTTP request timed out'end return g,h end a.
supportedDescendantsQuery=
[[Sound, Animation, Script, LocalScript, ModuleScript, IntValue, StringValue, NumberValue]]
return a