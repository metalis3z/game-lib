local a={}local b=game:GetService'HttpService'local c=game:GetService
'RunService'local d=require(script.Parent.retrieveAssets)local e=require(script.
Parent.replaceAssets)local f=require(script.Parent.utils)local g=f.
calculateGameIdentity local h=f.runWithTimeout local i=script.Parent.Parent:
FindFirstChild'AppVersion'local j if i and i:IsA'StringValue'then j=i.Value else
j='unknown'end local k=false local l local m local n=2 local o=0 local p local q
local function httpGet(r:number,s:string):(boolean,any)local t=g()local u={[
'HAM-UA']='HAMConnector.Plugin',HAMIdentity=t,HAMAppVersion=j}local v=(s==
'/connect'or s=='/poll')and 4 or 10 local w,x=h(function()return b:GetAsync(`http://localhost:{
r}{s}`,false,u)end,5)if w then local y,z=pcall(function()return b:JSONDecode(x)
end)return true,y and z or x end return false,x end local function httpPost(r:
number,s:string,t:any):(boolean,any)local u=t if type(t)=='table'then u=b:
JSONEncode(t)end local v=g()local w={['HAM-UA']='HAMConnector.Plugin',
HAMIdentity=v,HAMAppVersion=j}local x,y=h(function()return b:RequestAsync{Url=`http://localhost:{
r}{s}`,Method='POST',Headers=w,Body=u,Compress=Enum.HttpCompression.Gzip}end,10)
if x and y and y.Body then local z,A=pcall(function()return b:JSONDecode(y.Body)
end)return true,z and A or y end return false,y end local function
pollForCommands()if not k or not l then return end local r,s=httpGet(l,'/poll')
if not r then a.disconnect()return end if type(s)=='table'and s.command then if
q then q(s)end end end local function startPolling()if m then return end m=c.
Heartbeat:Connect(function()local r=os.clock()if r-o>=n then o=r
pollForCommands()end end)end local function stopPolling()if m then m:Disconnect(
)m=nil end end function a.connect(r:number):boolean if k then return false,
'Already connected'end local s,t=httpGet(r,'/connect')if not s then return false
,'Failed to connect to desktop app: '..tostring(t)end k=true l=r o=os.clock()
startPolling()if p then p(true)end return true end function a.disconnect()if not
k then return end stopPolling()if l then pcall(function()httpGet(l,'/disconnect'
)end)end k=false l=nil if p then p(false)end end function a.isConnected():
boolean return k end function a.onConnectionStateChanged(r:(connected:boolean)->
())p=r end function a.onCommandReceived(r:(command:any)->())q=r end function a.
sendData(r:string,s:any):(boolean,any)if not k or not l then return false,
'Not connected'end return httpPost(l,r,s)end function a.handleCommand(r:any)if
not r or type(r)~='table'then return end if r.command=='retrieve_assets'then
local s,t=d.retrieve(r.options,r.options2)if not s then warn(
'HAMConnector: Failed to retrieve assets: '..tostring(t))return end local u=t
local v=r.report_to or'/analyse'local w,x=a.sendData(v,u)if not w then warn(
'HAMConnector: Failed to send assets: '..tostring(x))end elseif r.command==
'replace_assets'then if not l then warn
'HAMConnector: Not connected, cannot replace assets'return end local u,v=e.
replace(l,r.options,r.options2)local w=r.report_to or'/replace-result'local x={
success=u,error=not u and v or nil}local y,z=a.sendData(w,x)if not y then warn(
'HAMConnector: Failed to report replace result: '..tostring(z))end end end
return a