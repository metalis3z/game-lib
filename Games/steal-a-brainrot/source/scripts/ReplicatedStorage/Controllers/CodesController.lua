--  █████╗ ███╗   ██╗ ██████╗ ███████╗██╗     ██╗   ██╗███████╗    ██████╗ ███████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ██╗██╗     ███████╗███████╗
-- ██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██║   ██║██╔════╝    ██╔══██╗██╔════╝██╔════╝ ██╔═══██╗████╗ ████║██╔══██╗██║██║     ██╔════╝██╔════╝
-- ███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ██║   ██║███████╗    ██║  ██║█████╗  ██║      ██║   ██║██╔████╔██║██████╔╝██║██║     █████╗  ███████╗
-- ██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ██║   ██║╚════██║    ██║  ██║██╔══╝  ██║      ██║   ██║██║╚██╔╝██║██╔═══╝ ██║██║     ██╔══╝  ╚════██║
-- ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╔╝███████║    ██████╔╝███████╗╚██████╗ ╚██████╔╝██║ ╚═╝ ██║██║     ██║███████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚══════╝    ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

-- @ Angelus Decompiles — @Chlorls & @imoRR
-- @ Discord : discord.gg/nDWm6PkFrT
-- @ Decompiled

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local InterfaceController = require(Controllers.InterfaceController)
local NotificationController = require(Controllers.NotificationController)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Classes = ReplicatedStorage:WaitForChild("Classes")
local AnimatedButton = require(Classes.AnimatedButton)
local CodesFlags = require(ReplicatedStorage.Shared.ConchTypes.CodesFlags)
local PlayerGui = Players.LocalPlayer.PlayerGui
local Codes = PlayerGui:WaitForChild("Codes").Codes
local Codes2 = PlayerGui:WaitForChild("LeftCenter").LeftCenter.Buttons:WaitForChild("Codes")
local v1 = nil
local t = {}

local function initTextbox(p1, p2) --[[ initTextbox | Line: 32 | Upvalues: NotificationController (copy), Net (copy), AnimatedButton (copy) ]]
	local v1 = false

	local function submitCode() --[[ submitCode | Line: 35 | Upvalues: v1 (ref), p1 (copy), NotificationController (ref), Net (ref) ]]
		if v1 or not p1.Active then
			return
		end

		local Text = p1.Text

		if #Text < 1 then
			NotificationController:Error("Invalid code")

			return
		end

		v1 = true
		p1.Text = ""
		p1.PlaceholderText = "Redeeming..."
		p1.Selectable = false
		p1.Active = false
		p1:ReleaseFocus()

		local ok, result, result2 = pcall(function() --[[ Line: 54 | Upvalues: Net (ref), Text (copy) ]]
			return Net:RemoteFunction("RequestRedemption"):InvokeServer(Text)
		end)

		if ok then
			if result then
				if not (ok and result) then
					p1.Text = ""
					p1.PlaceholderText = "Code Here..."
					task.wait(0.5)
					p1.Selectable = true
					p1.Active = true
					v1 = false

					return
				end

				-- NotificationController:Success(if typeof(result2) == "string" then result2 else "Code redeemed!")
			else
				-- NotificationController:Error(if typeof(result2) == "string" then result2 else "Request failed")
			end
		else
			NotificationController:Error("Unexpected error")
			warn(result)
		end

		p1.Text = ""
		p1.PlaceholderText = "Code Here..."
		task.wait(0.5)
		p1.Selectable = true
		p1.Active = true
		v1 = false
	end

	p1.FocusLost:Connect(function(p1) --[[ Line: 76 | Upvalues: submitCode (copy) ]]
		if p1 then
			submitCode()
		end
	end)

	if not p2 then
		p1:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 91 | Upvalues: p1 (copy) ]]
			local Text = p1.Text
			local v3 = string.sub(string.upper((string.gsub(Text, "[^%w]", ""))), 1, 50)

			if v3 == Text then
				return
			end

			p1.Text = v3
		end)

		return
	end

	local v2 = AnimatedButton.new(p2)

	v2:Animate()
	v2.OnActivated:Connect(submitCode)
	p1:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 91 | Upvalues: p1 (copy) ]]
		local Text = p1.Text
		local v3 = string.sub(string.upper((string.gsub(Text, "[^%w]", ""))), 1, 50)

		if v3 == Text then
			return
		end

		p1.Text = v3
	end)
end

function t.Start(p1) --[[ Start | Line: 105 | Upvalues: v1 (ref), InterfaceController (copy), Codes (copy), initTextbox (copy), CodesFlags (copy), Codes2 (copy) ]]
	v1 = InterfaceController:Register("Codes", Codes, "TopQuint")
	v1:AttachCloseButton(Codes.Header.Close)
	v1:Close()
	initTextbox(Codes.CodeRedeem.TextBox, Codes.Confirm)

	local function updateEnabled() --[[ updateEnabled | Line: 113 | Upvalues: CodesFlags (ref), Codes2 (ref), v1 (ref), InterfaceController (ref) ]]
		local v12 = CodesFlags.Enabled:Get()

		Codes2.Visible = v12

		if v12 or not v1:IsOpened() then
			return
		end

		InterfaceController:Toggle("Codes", false)
	end

	local v12 = CodesFlags.Enabled:Get()

	Codes2.Visible = v12

	if v12 or not v1:IsOpened() then
		CodesFlags.Enabled.Changed:Connect(updateEnabled)

		return
	end

	InterfaceController:Toggle("Codes", false)
	CodesFlags.Enabled.Changed:Connect(updateEnabled)
end

return t