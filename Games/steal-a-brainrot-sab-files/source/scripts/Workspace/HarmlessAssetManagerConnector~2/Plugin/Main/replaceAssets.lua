local a={}local b=game:GetService'HttpService'local c=game:GetService
'ChangeHistoryService'local d=game:GetService'ScriptEditorService'local e=
require(script.Parent.utils)local f=e.normalise_asset_id local g=e.base64Decode
local h=e.gzipDecompress local i=e.pullScriptAssets local j=e.
supportedDescendantsQuery local function fetchIdMap(k:number):(boolean,table)
local l,m=pcall(function()local l={['HAM-UA']='HAMConnector.Plugin'}return b:
GetAsync(`http://localhost:{k}/id-map`,false,l)end)if not l then return false,
'Failed to fetch id_map: '..tostring(m)end local n,o=h(g(m))if not n then return
false,'Failed to decompress id_map'end local p,q=pcall(function()return b:
JSONDecode(o)end)if not p then return false,'Failed to parse id_map JSON'end
return true,q end function replaceAssetIds(k,l:table,m:table)local n=l or{}local
o=m or{}if next(n)==nil then warn
[[HAMConnector: No sources selected for replacement. This shouldn't happen.]]
return false,'No sources selected for replacement.'end local p,q=pcall(function(
)local p=game:QueryDescendants(j)for q,r in pairs(p)do local s if table.find(n,
'Instances')then for t,u in pairs(o)do if u=='Sounds'and r:IsA'Sound'then local
v=r.SoundId or''s=f(v)local w=k and k[s]or nil if s and s~=''and w then local x=
`rbxassetid://`..w r.SoundId=x end continue elseif u=='Animations'and r:IsA
'Animation'then s=f(r.AnimationId)local v=k and k[s]or nil if s and s~=''and v
then r.AnimationId=`rbxassetid://`..v end continue end end end if table.find(n,
'Scripts')then if r:IsA'Script'or r:IsA'LocalScript'or r:IsA'ModuleScript'then
local t=i(r)local u=r.Source for v,w in pairs(t)do local x=k and k[w]or nil
local y=tostring(w or'')if x then if not tonumber(x)then continue end local z=y:
gsub('([^%w])','%%%1')local A='%f[%d]'..z..'%f[%D]'u=u:gsub(A,tostring(x))if#u>=
6291456 then warn
[[HAMConnector: Script replacement would exceed max size. Skipping.]]u=r.Source
break end end end if u~=r.Source then d:UpdateSourceAsync(r,function(v)return u
end)end continue end end if table.find(n,'Int/Str/Num Values')then if r:IsA
'IntValue'or r:IsA'StringValue'or r:IsA'NumberValue'then local t=tostring(r.
Value)s=f(t)local u=k and k[s]or nil if s and s~=''and u then if r:IsA'IntValue'
then r.Value=tonumber(u)or r.Value elseif r:IsA'NumberValue'then r.Value=
tonumber(u)or r.Value elseif r:IsA'StringValue'then r.Value=u end end continue
end end end return true end)if not p then warn
'HAMConnector: Error during asset replacement!'return false,tostring(q)end
return true end function a.replace(k:number,l:table,m:table):(boolean,string)
local n,o=fetchIdMap(k)if not n or not o then if o then return false,tostring(o)
end return false,'Failed to fetch id map from desktop app'end if type(o)~=
'table'then return false,'Invalid id map format'end local p=c:TryBeginRecording
'Replace asset IDs'local q,r=replaceAssetIds(o,l,m)if not q then c:
FinishRecording(p,Enum.FinishRecordingOperation.Cancel)warn
'HAMConnector: Error during asset replacement!'return false,
'Error during asset replacement: '..tostring(r)end c:FinishRecording(p,Enum.
FinishRecordingOperation.Commit)return true,'Asset replacement completed'end
return a