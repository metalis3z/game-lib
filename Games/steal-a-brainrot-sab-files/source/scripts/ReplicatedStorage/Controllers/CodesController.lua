-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local InterfaceController = require(Controllers.InterfaceController)
local NotificationController = require(Controllers.NotificationController)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Classes = ReplicatedStorage:WaitForChild("Classes")
local AnimatedButton = require(Classes.AnimatedButton)
local CodesFlags = require(ReplicatedStorage.Shared.Flags.CodesFlags)
local PlayerGui = Players.LocalPlayer.PlayerGui
local Codes = PlayerGui:WaitForChild("Codes").Codes
local Codes2 = PlayerGui:WaitForChild("LeftCenter").LeftCenter.Buttons:WaitForChild("Codes")
local u14 = nil
local t1 = {}

local function initTextbox(p1, p2)
	local u19 = false

	local function submitCode()
		if u19 or not p1.Active then
			return
		end

		local p1Text = p1.Text

		if #p1Text < 1 then
			NotificationController:Error("Invalid code")

			return
		end

		u19 = true
		p1.Text = ""
		p1.PlaceholderText = "Redeeming..."
		p1.Selectable = false
		p1.Active = false
		p1:ReleaseFocus()

		local ok, result, v28 = pcall(function()
			return Net:RemoteFunction("RequestRedemption"):InvokeServer(p1Text)
		end)

		if not ok then
			NotificationController:Error("Unexpected error")
			warn(result)
		elseif not result then
			NotificationController:Error(typeof(v28) ~= "string" and "Request failed" or v28)
		elseif ok and result then
			NotificationController:Success(typeof(v28) ~= "string" and "Code redeemed!" or v28)
		end

		p1.Text = ""
		p1.PlaceholderText = "Code Here..."
		task.wait(0.5)
		p1.Selectable = true
		p1.Active = true
		u19 = false
	end

	p1.FocusLost:Connect(function(enterPressed: boolean)
		if not enterPressed then
			return
		end

		submitCode()
	end)

	if p2 then
		local v21 = AnimatedButton.new(p2)

		v21:Animate()
		v21.OnActivated:Connect(submitCode)
	end

	p1:GetPropertyChangedSignal("Text"):Connect(function()
		local p1Text = p1.Text
		local v31 = string.gsub(p1Text, "[^%w]", "")
		local v32 = string.sub(string.upper(v31), 1, 50)

		if v32 ~= p1Text then
			p1.Text = v32
		end
	end)
end

function t1.Start(_)
	u14 = InterfaceController:Register("Codes", Codes, "TopQuint")
	u14:AttachCloseButton(Codes.Header.Close)
	u14:Close()
	initTextbox(Codes.CodeRedeem.TextBox, Codes.Confirm)

	local function updateEnabled()
		local v33 = CodesFlags.Enabled:Get()

		Codes2.Visible = v33

		if not v33 and u14:IsOpened() then
			InterfaceController:Toggle("Codes", false)
		end
	end

	local v24 = CodesFlags.Enabled:Get()

	Codes2.Visible = v24

	if not v24 and u14:IsOpened() then
		InterfaceController:Toggle("Codes", false)
	end

	CodesFlags.Enabled.Changed:Connect(updateEnabled)
end

return t1
