local Local_Player = game.Players.LocalPlayer
local GUI_Frame = script.Parent
local GUI_Content = GUI_Frame.Window.Content
local GUI_Categories = GUI_Content.Categories
local GUI_Menus = GUI_Categories.Menus
local GUI_MapLoader = GUI_Categories.MapLoader
local GUI_Pages = GUI_Content.Pages
local LastOpen = "Output" --default
local Output = ""
local Freeze = false
local MapData = game.ReplicatedStorage.Remote.ReqMapData:InvokeServer()
local FE2Library = require(game.ReplicatedStorage.SharedModules.FE2Library)
local rem = game.ReplicatedStorage.Remote
local Inf_Jump_Connection = nil

local Setting_Data = {
	["Inf Jump"] = {
		Function = function(arg1)
			if arg1 then
				Inf_Jump_Connection = game:GetService("UserInputService").JumpRequest:Connect(function()
					local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
					humanoid:ChangeState('Jumping')
				end)
			else
				Inf_Jump_Connection:Disconnect()
			end
		end,
		Type = {
			boolean = true,
			default = "Off"
		}
	}
}

local function OpenPage(Name : string)
	GUI_Pages[Name].Visible = true
	if LastOpen ~= "" and LastOpen ~= nil then
		GUI_Pages[LastOpen].Visible = false
	end
	LastOpen = Name
end

local Admins = {}

local function AddOutput(AddedText)
	if not Freeze then
		Output = Output .. AddedText
		local TestFrame = Instance.new("Frame")
		TestFrame.Size = UDim2.new(1, 0, 1, 0)
		TestFrame.Parent = GUI_Pages.Output
		TestFrame.ZIndex = -1
		game:GetService("TweenService"):Create(TestFrame, TweenInfo.new(0.75), {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.75}):Play()
		GUI_Pages.Output.Info.Text = Output
		local t = game:GetService("TweenService"):Create(TestFrame, TweenInfo.new(0.75), {BackgroundColor3 = Color3.fromRGB(54, 66, 54), BackgroundTransparency = 0})
		t:Play()
		repeat task.wait() until t.PlaybackState == Enum.PlaybackState.Completed
		TestFrame:Destroy()
	end
end
local function Clear()
	Output = ""
	GUI_Pages.Output.Info.Text = Output
	local TestFrame = Instance.new("Frame")
	TestFrame.Size = UDim2.new(1, 0, 1, 0)
	TestFrame.Parent = GUI_Pages.Output
	TestFrame.ZIndex = -1
	local a = game:GetService("TweenService"):Create(TestFrame, TweenInfo.new(0.75), {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.75})
	a:Play()
	repeat task.wait() until a.PlaybackState == Enum.PlaybackState.Completed
	local t = game:GetService("TweenService"):Create(TestFrame, TweenInfo.new(0.75), {BackgroundColor3 = Color3.fromRGB(54, 66, 54), BackgroundTransparency = 0})
	t:Play()
	repeat task.wait() until t.PlaybackState == Enum.PlaybackState.Completed
	TestFrame:Destroy()
end

local function CreateSettings(Settings_Table)
	for SettingName, SettingData in next, Settings_Table do
		if SettingData.Type.boolean == true then
			local New_Setting = script.SettingButton_boolean:Clone()
			New_Setting.Parent = GUI_Pages.Settings
			New_Setting.SettingName.Text = SettingName
			New_Setting.Status.Text = SettingData.Type.default or "On"
			New_Setting.Status.BackgroundColor3 = (New_Setting.Status.Text == "Off" and Color3.fromRGB(192, 57, 43)) or (New_Setting.Status.Text == "On" and Color3.fromRGB(39, 174, 96))
			New_Setting.Status.MouseButton1Click:Connect(function()
				if New_Setting.Status.Text == "On" then
					New_Setting.Status.Text = "Off"
					New_Setting.Status.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
				else
					New_Setting.Status.Text = "On"
					New_Setting.Status.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
				end
				if typeof(SettingData.Function) == "function" then
					SettingData.Function(New_Setting.Status.Text == "On")
				end
			end)
		end
	end
end
local function CountNumberOfStuff(frame : Frame)
	local count = 0
	for _, v in next, frame:GetDescendants() do
		if v:IsA("Frame") then
			count += 1
		end
	end
	return count
end
local function AddNewMap(MapData : table, Type : string)
	local NewMap = script.Map_Container:Clone()
	local Info = NewMap.Map_Frame.Info_BG
	NewMap.Parent = GUI_Pages.MapList[Type .. "_Frame"].Container
	Info.Image = "rbxassetid://" .. MapData.imgID
	Info.Creator.TextColor3 = FE2Library.Difficulties[math.floor(MapData.difficulty)][2]
	Info.MapName.TextColor3 = FE2Library.Difficulties[math.floor(MapData.difficulty)][2]
	Info.MapName.Text = MapData.name
	Info.Creator.Text = MapData.Creator
	AddOutput("\nLoaded New Map: " .. MapData.name)
	local c = GUI_Pages.MapList["Active" .. "_Frame"] :: ScrollingFrame
	local a = 0
	for _, v in next, GUI_Pages.MapList.Active_Frame.Container:GetChildren() do
		if v:IsA("Frame") then
			a += 1
		end
	end
	a *= 1/6
	c.CanvasSize = UDim2.new(0, 0, a, 0)
	Info.Actions_Frame.Actions.ButtonCount.Amount.Text = tostring(MapData.buttonCount)
	Info.Actions_Frame.Actions.StarRating.RatingNumber.Text = tostring(MapData.difficulty)	
	Info.Actions_Frame.Actions.Del.MouseButton1Click:Connect(function()
		game.ReplicatedStorage.Remote.DeleteMap:FireServer(MapData.name)
		NewMap:Destroy()
	end)
end

local function Init()
	AddOutput("Flood Escape 2: Escape Timeline Runner V2")
	AddOutput("You are trusted! Here's some rules\n• Don't break stuff\n• Don't be bad")
	CreateSettings(Setting_Data)
	for _, dif in ipairs(MapData) do
		for _, mapData in ipairs(dif) do
			AddNewMap(mapData, "Active")
		end
	end
	for _, Button in ipairs(GUI_Menus:GetChildren()) do
		if Button:IsA("TextButton") then
			Button.MouseButton1Click:Connect(function()
				if LastOpen ~= Button.Name then
					local LastBTN = GUI_Menus:FindFirstChild(LastOpen)
					LastBTN.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
					Button.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
					OpenPage(Button.Name)
				end
			end)
		end
	end
end

Init()

GUI_Pages.Output.Freeze.MouseButton1Click:Connect(function()
	Freeze = not Freeze
end)

GUI_Pages.Output.Clear.MouseButton1Click:Connect(Clear)

rem.SendOutput.OnClientEvent:Connect(function(...)
	if table.find(Admins, Local_Player.UserId) then
		AddOutput("\n Server: " .. ...)
	end
end)