local a={}local b=require(script.Parent.utils)local c=b.pullScriptAssets local d
=b.normalise_asset_id local e=b.supportedDescendantsQuery local function getPath
(f:Instance?):string if not f then return''end local g=''local h:Instance?=f
while h and h~=game do if g==''then g=h.Name else g=h.Name..'/'..g end h=h.
Parent end return g end type AssetInfoPartial={asset_id:string,name:string,
class_name:string,parent_path:string,source:string}function a.retrieve(f:any,g:
any):(boolean,any)local h=f or{}local i=g or{}local j={}local k,l=pcall(function
()local k=game:QueryDescendants(e)for l,m in pairs(k)do if table.find(h,
'Instances')then if table.find(i,'Sounds')and m:IsA'Sound'then local n=m.SoundId
or''local o=d(n)if o and o~=''then table.insert(j,{asset_id=o,name=m.Name,
class_name=m.ClassName,parent_path=getPath(m.Parent),source='Instance'}::
AssetInfoPartial)end elseif table.find(i,'Animations')and m:IsA'Animation'then
local n=d(m.AnimationId)if n and n~=''then table.insert(j,{asset_id=n,name=m.
Name,class_name=m.ClassName,parent_path=getPath(m.Parent),source='Instance'}::
AssetInfoPartial)end end end if table.find(h,'Scripts')and(m:IsA'Script'or m:IsA
'LocalScript'or m:IsA'ModuleScript')then local n=c(m)for o,p in pairs(n)do table
.insert(j,{asset_id=p,name='Load Data',class_name='Load Data',parent_path=
getPath(m),source='Script'}::AssetInfoPartial)end end if table.find(h,
'Int/Str/Num Values')then if m:IsA'IntValue'or m:IsA'StringValue'or m:IsA
'NumberValue'then local n=tostring(m.Value)local o=d(n)if o and o~=''then table.
insert(j,{asset_id=o,name='Load Data',class_name='Load Data',parent_path=
getPath(m.Parent),source='Value'}::AssetInfoPartial)end end end end end)if not k
then warn'HAMConnector: Error during asset retrieval!'return false,tostring(l)
end return k,j end return a