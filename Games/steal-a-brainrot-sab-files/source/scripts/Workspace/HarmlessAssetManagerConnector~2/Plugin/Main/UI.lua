local a={}local b=require(script.Parent.connectionManager)local c local d
local function updateButtonState(e:boolean)if not c then return end if e then c.
Text='Disconnect'c.BackgroundColor3=Color3.fromRGB(220,80,80)if d then d.Text=
'Status: Connected'd.TextColor3=Color3.fromRGB(80,220,80)end else c.Text=
'Connect'c.BackgroundColor3=Color3.fromRGB(80,160,220)if d then d.Text=
'Status: Disconnected'd.TextColor3=Color3.fromRGB(150,150,150)end end end
local function onConnectButtonClicked(e:Plugin)if b.isConnected()then b.
disconnect()else local f=e:GetSetting'HAMConnector_Port'or 31677 local g,h=b.
connect(f)if not g then warn('HAMConnector: Failed to connect:',h)if d then d.
Text='Status: Connection Failed'd.TextColor3=Color3.fromRGB(220,80,80)task.wait(
2)updateButtonState(false)end end end end function a.init(e:DockWidgetPluginGui,
f:Plugin)d=Instance.new'TextLabel'd.BorderSizePixel=0 d.Size=UDim2.new(0.9,0,
0.25,0)d.Position=UDim2.new(0.05,0,0.1,0)d.BackgroundTransparency=1 d.TextScaled
=true d.TextColor3=Color3.fromRGB(150,150,150)d.Text='Status: Disconnected'd.
Font=Enum.Font.GothamBold d.Parent=e c=Instance.new'TextButton'c.BorderSizePixel
=0 c.Size=UDim2.new(0.75,0,0.4,0)c.Position=UDim2.new(0.5,0,0.5,0)c.
SizeConstraint=Enum.SizeConstraint.RelativeXY c.TextScaled=true c.TextColor3=
Color3.new(1,1,1)c.BackgroundColor3=Color3.fromRGB(80,160,220)c.AnchorPoint=
Vector2.new(0.5,0)c.Text='Connect'c.Font=Enum.Font.GothamBold c.Parent=e local g
=Instance.new'UICorner'g.CornerRadius=UDim.new(0.2,0)g.Parent=c c.
MouseButton1Click:Connect(function()onConnectButtonClicked(f)end)b.
onConnectionStateChanged(updateButtonState)b.onCommandReceived(function(h)b.
handleCommand(h)end)updateButtonState(b.isConnected())end return a