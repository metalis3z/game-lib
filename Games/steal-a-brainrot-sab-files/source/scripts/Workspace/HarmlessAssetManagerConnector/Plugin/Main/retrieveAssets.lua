local a={}local b=require(script.Parent.utils)local c=b.pullScriptAssets local d
=b.normalise_asset_id type AssetInfoPartial={asset_id:string,name:string,
class_name:string,parent_path:string,source:string}function a.retrieve(e:any,f:
any):(boolean,any)local g=e or{}local h=f or{}local i={}local j,k=pcall(function
()for j,k in pairs(game:GetDescendants())do if table.find(g,'Instances')then if
table.find(h,'Sounds')and k:IsA'Sound'then local l if d(k.AudioContent)~=''then
l=k.AudioContent else l=k.SoundId end local m=d(l)if m and m~=''then table.
insert(i,{asset_id=m,name=k.Name,class_name=k.ClassName,parent_path=k.Parent and
k.Parent:GetFullName()or'',source='Instance'}::AssetInfoPartial)end elseif table
.find(h,'Animations')and k:IsA'Animation'then local l=d(k.AnimationId)if l and l
~=''then table.insert(i,{asset_id=l,name=k.Name,class_name=k.ClassName,
parent_path=k.Parent and k.Parent:GetFullName()or'',source='Instance'}::
AssetInfoPartial)end end end if table.find(g,'Scripts')and(k:IsA'Script'or k:IsA
'LocalScript'or k:IsA'ModuleScript')then local l=c(k)for m,n in pairs(l)do table
.insert(i,{asset_id=n,name='Load Data',class_name='Load Data',parent_path=k.
Parent and k.Parent:GetFullName()or'',source='Script'}::AssetInfoPartial)end end
if table.find(g,'Int/Str/Num Values')then if k:IsA'IntValue'or k:IsA
'StringValue'or k:IsA'NumberValue'then local l=tostring(k.Value)local m=d(l)if m
and m~=''then table.insert(i,{asset_id=m,name='Load Data',class_name='Load Data'
,parent_path=k.Parent and k.Parent:GetFullName()or'',source='Value'}::
AssetInfoPartial)end end end end end)if not j then warn
'HAMConnector: Error during asset retrieval!'return false,tostring(k)end return
j,i end return a