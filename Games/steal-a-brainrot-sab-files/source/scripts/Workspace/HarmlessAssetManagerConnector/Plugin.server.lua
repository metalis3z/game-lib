local a=require(script.Main.UI)local b=game:GetService'RunService'local c=game:
GetService'HttpService'local d=game:GetService'ChangeHistoryService'if not b:
IsEdit()then return end local e=plugin:CreateToolbar'Harmless Asset Manager'
local f=e:CreateButton('Harmless Asset Manager Connector',
'Connect to Harmless Asset Manager','rbxassetid://75465813068087')f.
ClickableWhenViewportHidden=true local g=DockWidgetPluginGuiInfo.new(Enum.
InitialDockState.Float,false,false,200,100,200,100)local h=plugin:
CreateDockWidgetPluginGuiAsync('Harmless Asset Manager',g)h.Title=
'Harmless Asset Manager Connector'local function onPluginButtonClicked()h.
Enabled=not h.Enabled end f.Click:Connect(onPluginButtonClicked)h:
GetPropertyChangedSignal'Enabled':Connect(function()f:SetActive(h.Enabled)end)
local i=31677 if plugin:GetSetting'HAMConnector_Port'~=i then plugin:SetSetting(
'HAMConnector_Port',i)end local j='HAMGameUUID'if not game:GetAttribute(j)then
local k=d:TryBeginRecording'Set HAM Game UUID'game:SetAttribute(j,c:
GenerateGUID(false))d:FinishRecording(k,Enum.FinishRecordingOperation.Commit)end
a.init(h,plugin)