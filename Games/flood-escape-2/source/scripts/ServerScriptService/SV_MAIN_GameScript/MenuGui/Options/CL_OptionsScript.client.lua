local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local cl_main = Players.LocalPlayer.PlayerScripts:WaitForChild("CL_MAIN_GameScript")
local window = script.Parent.Window
local categories = window.Content.Categories
local pages = window.Content.Pages
local library = require(game.ReplicatedStorage.SharedModules.FE2Library)
local remote = game.ReplicatedStorage.Remote
local player = Players.LocalPlayer
local bindingkey = nil
local optiondata = cl_main.GetOptions:Invoke()
local currentPage = nil

local function ChangePage(pageName)
	bindingkey = nil
	for i,v in next, categories:GetChildren() do
		if v:IsA("TextButton") then
			if v.Name == pageName then
v.BackgroundColor3 = Color3.fromRGB(52, 152, 219) else v.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
		end
	end
end
	for i,v in next, pages:GetChildren() do
		if v:IsA("Frame") then
			v.Visible = false
			if v.Name == pageName then
				currentPage = pageName
				v.Visible = true
				v.UIScale.Scale = 0
				game:GetService("TweenService"):Create(v.UIScale, TweenInfo.new(.315,Enum.EasingStyle.Quint), {Scale = 1}):Play()
			end
		end
	end
end

for i,v in next, categories:GetChildren() do
	if v:IsA("TextButton") then
		v.Activated:Connect(function()
			ChangePage(v.Name)
		end)
	end
end

local function OptionsCreate()
	local title = script.Title:Clone()
	title.Name = "Title_Options"
	title.Text = "Options"
	title.LayoutOrder = 0
	title.Parent = categories
	categories.Title_Version.Text = "Version: " .. game.ReplicatedStorage.Config:GetAttribute("BuildVersion")

	for section, sectionData in next, optiondata do
-- this sets up the button
		local setupbtn = Instance.new("TextButton")
		setupbtn.Font = "Ubuntu"
		setupbtn.TextScaled = true
		setupbtn.TextColor3 = Color3.new(1, 1, 1)
		setupbtn.TextStrokeTransparency = 0.65
		setupbtn.Text = ""
		setupbtn.BorderSizePixel = 0
		setupbtn.BackgroundColor3 = Color3.fromRGB(149, 165, 166)
		setupbtn.Name = section

-- this sets up the text label
		local desc = Instance.new("TextLabel")
		desc.TextColor3 = Color3.new(1, 1, 1)
		desc.TextStrokeTransparency = 0.65
		desc.Size = UDim2.new(1,0,1,0)
		desc.Name = "Desc"
		desc.BackgroundTransparency = 1
		desc.Font = "Ubuntu"
		desc.TextScaled = true
		desc.Parent = setupbtn
		script.UICorner:Clone().Parent = setupbtn
		script.UIGradient:Clone().Parent = setupbtn
		setupbtn.Parent = categories
		desc.Text = section
--
		local thisPage = script.PageWindow:Clone()
		thisPage.Name = section
		thisPage.Parent = pages
		for optId, optTable in next, sectionData do
			local optBtn = script.OptionButton:Clone()
			optBtn.Name = tostring(optId)
			optBtn.LayoutOrder = optTable.LayoutOrder
			local optName = optTable.Name
			if section == "Main" then
				optBtn.OptionName.Text = optName
				if optTable.Property.Type == "boolean" then
					if optTable.Property.Value == true then
						optBtn.Status.Text = "On"
						optBtn.Status.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
					else
						optBtn.Status.Text = "Off"
						optBtn.Status.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
					end
				end
				if optTable.Property.Type == "cycle" then
					optBtn.Status.Text = optTable.Property.Cycles[optTable.Property.Value]
				end
				optBtn.MouseButton1Click:connect(function()
					remote.UpdOptions:FireServer(optId)
				end)
				if optTable.Property.Type == "manual" then
					optBtn.Status.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
					optBtn.Status.Text = ''
					local frameinput = script.Input:Clone()
					frameinput.Parent = optBtn.Status
					frameinput.Text = optTable.Property.Value
					frameinput.FocusLost:Connect(function()
						if tonumber(frameinput.Text) then
							local InputNumber
							InputNumber = tonumber(frameinput.Text)
							remote.UpdOptions:FireServer(optId, nil, nil, InputNumber)
						end
					end)
				end
			end
			if section == "Others" then
				optBtn.OptionName.Text = optName
				if optTable.Property.Type == "boolean" then
					if optTable.Property.Value == true then
						optBtn.Status.Text = "On"
						optBtn.Status.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
					else
						optBtn.Status.Text = "Off"
						optBtn.Status.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
					end
					optBtn.MouseButton1Click:connect(function()
						remote.UpdOptions:FireServer(optId, nil, "Others", nil)
					end)
				end
				if optTable.Property.Type == "manual" then
					optBtn.Status.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
					optBtn.Status.Text = ''
					local frameinput = script.Input:Clone()
					frameinput.Parent = optBtn.Status
					frameinput.Text = optTable.Property.Value
					frameinput.FocusLost:Connect(function()
						if tonumber(frameinput.Text) then
							local InputNumber
							InputNumber = tonumber(frameinput.Text)
							remote.UpdOptions:FireServer(optId, nil, "Others", InputNumber)
						end
					end)
				end
			end
			if section == "Controls" then
				local BindButton = script.ControlOptionButton:Clone()
				BindButton.Name = optId
				BindButton.OptionName.Text = optName
				BindButton.Status_Keyboard.Text = optTable.KeyString.Keyboard
				BindButton.Status_Gamepad.Text = optTable.KeyString.Gamepad
				BindButton.Activated:connect(function(a1)
					if bindingkey == nil then
						if a1.UserInputType == Enum.UserInputType.Gamepad1 then
							game:GetService("GuiService").SelectedObject = nil
						end
						bindingkey = optId
						BindButton.OptionName.Text = "Press Input"
						BindButton.BackgroundTransparency = 0.2
						while bindingkey == optId and currentPage == "Controls" do
							wait()
						end
						BindButton.OptionName.Text = optName
						BindButton.BackgroundTransparency = 1
					end
				end)
				BindButton.Parent = thisPage
			end
			if section ~= "Controls" then
				optBtn.Parent = thisPage
			end
		end
		local optrow = {}
		for i, btn in next, thisPage:GetChildren() do
			if btn:IsA("GuiButton") then
				table.insert(optrow, btn)
			end
		end
		local grid = Instance.new("UIGridLayout")
		grid.CellSize = UDim2.new(1, 0, math.clamp((1) / #optrow, 0, 0.12), 0)
		grid.CellPadding = UDim2.new()
		grid.SortOrder = Enum.SortOrder.LayoutOrder
		grid.Parent = thisPage
		setupbtn.Activated:Connect(function()
			ChangePage(setupbtn.Name)
		end)
	end
	cl_main.RefreshOptions.Event:Connect(function(newData)
		bindingkey = nil

		for section, sectionData in next, newData do
			for optId, data in next, sectionData do
				if section == "Main" then
					local label = ""
					if data.Property.Type == "boolean" then
						label = data.Property.Value == true and "On" or "Off"
						pages[section][optId].Status.BackgroundColor3 = data.Property.Value == true and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
					elseif data.Property.Type == "cycle" then
						label = data.Property.Cycles[data.Property.Value] or "Error"
					end
					pages[section][optId].Status.Text = label
				end
				if section == "Controls" then
					pages[section][optId].OptionName.Text = data.Name
					pages[section][optId].Status_Gamepad.Text = data.KeyString.Gamepad
					pages[section][optId].Status_Keyboard.Text = data.KeyString.Keyboard
				end
				if section == "Others" then
					pages[section][optId].OptionName.Text = data.Name
					pages[section][optId].Status.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
					local label = ""
					if data.Property.Type == "boolean" then
						pages[section][optId].Status.Text = data.Name
						label = data.Property.Value == true and "On" or "Off"
						pages[section][optId].Status.BackgroundColor3 = data.Property.Value == true and Color3.fromRGB(39, 174, 96) or Color3.fromRGB(192, 57, 43)
						pages[section][optId].Status.Text = label
					elseif data.Property.Type == "manual" then
						pages[section][optId].Status.Text = ''
						label = data.Property.Value or "Error"
						pages[section][optId].Status.Input.Text = label
					end
				end
			end
		end
	end)
end

OptionsCreate() -- this makes the options

ChangePage("Main") -- this is for when player spawns

game:GetService("UserInputService").InputBegan:connect(function(input)
	if bindingkey and input.KeyCode and (input.UserInputType.Value == 8 or input.UserInputType.Value >= 12 and input.UserInputType.Value <= 19) then
		local InputDevice
		if input == Enum.UserInputType.Gamepad1 then
			InputDevice = "Gamepad"
		else
			InputDevice = "Keyboard"
		end
		remote.UpdOptions:FireServer(bindingkey, input.KeyCode.Name, "Controls", InputDevice)
		bindingkey = nil
	end
end)

window.BottomBar.Close.MouseButton1Click:Connect(function()
	bindingkey = nil
	cl_main.ViewMenu:Fire()
end)