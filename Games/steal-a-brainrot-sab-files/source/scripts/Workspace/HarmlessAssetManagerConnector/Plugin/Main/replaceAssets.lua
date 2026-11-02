local a={}local b=game:GetService'HttpService'local c=game:GetService
'ChangeHistoryService'local d=require(script.Parent.utils)local e=d.
normalise_asset_id local f=d.base64Decode local g=d.gzipDecompress local h=d.
pullScriptAssets local function fetchIdMap(i:number):(boolean,table)local j,k=
pcall(function()local j={['HAM-UA']='HAMConnector.Plugin'}return b:GetAsync(`http://localhost:{
i}/id-map`,false,j)end)if not j then return false,'Failed to fetch id_map: '..
tostring(k)end local l,m=g(f(k))if not l then return false,
'Failed to decompress id_map'end local n,o=pcall(function()return b:JSONDecode(m
)end)if not n then return false,'Failed to parse id_map JSON'end return true,o
end function replaceAssetIds(i,j:table,k:table)local l,m=pcall(function()for l,m
in pairs(game:GetDescendants())do local n if table.find(j,'Instances')then for o
,p in pairs(k)do if p=='Sounds'and m:IsA'Sound'then local q if e(m.AudioContent)
~=''then q=m.AudioContent else q=m.SoundId end n=e(q)local r=i and i[n]or nil if
n and n~=''and r then if e(m.AudioContent)~=''then m.AudioContent=`rbxassetid://`
..r else m.SoundId=`rbxassetid://`..r end end continue elseif p=='Animations'and
m:IsA'Animation'then n=e(m.AnimationId)local q=i and i[n]or nil if n and n~=''
and q then m.AnimationId=`rbxassetid://`..q end continue end end end if table.
find(j,'Scripts')then if m:IsA'Script'or m:IsA'LocalScript'or m:IsA
'ModuleScript'then local o=h(m)local p=m.Source for q,r in pairs(o)do local s=i
and i[r]or nil local t=tostring(r or'')if s then if not tonumber(s)then continue
end local u=t:gsub('([^%w])','%%%1')local v='%f[%d]'..u..'%f[%D]'p=p:gsub(v,
tostring(s))if#p>=200000 then warn
[[HAMConnector: Script replacement would exceed max size. Skipping.]]p=m.Source
break end end end if p~=m.Source then m.Source=p end continue end end if table.
find(j,'Int/Str/Num Values')then if m:IsA'IntValue'or m:IsA'StringValue'or m:IsA
'NumberValue'then local o=tostring(m.Value)n=e(o)local p=i and i[n]or nil if n
and n~=''and p then if m:IsA'IntValue'then m.Value=tonumber(p)or m.Value elseif
m:IsA'NumberValue'then m.Value=tonumber(p)or m.Value elseif m:IsA'StringValue'
then m.Value=p end end continue end end end return true end)if not l then warn
'HAMConnector: Error during asset replacement!'return false,tostring(m)end
return true end function a.replace(i:number,j:table,k:table):(boolean,string)
local l,m=fetchIdMap(i)if not l or not m then if m then return false,tostring(m)
end return false,'Failed to fetch id map from desktop app'end if type(m)~=
'table'then return false,'Invalid id map format'end local n=c:TryBeginRecording
'Replace asset IDs'local o,p=replaceAssetIds(m,j,k)if not o then c:
FinishRecording(n,Enum.FinishRecordingOperation.Cancel)warn
'HAMConnector: Error during asset replacement!'return false,
'Error during asset replacement: '..tostring(p)end c:FinishRecording(n,Enum.
FinishRecordingOperation.Commit)return true,'Asset replacement completed'end
return a