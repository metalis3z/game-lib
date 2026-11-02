
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local RedeemCode = Net:RemoteFunction("MerchShop/RedeemCode")

local TextBox = script.Parent
local Placeholder = "Code Here..."
TextBox.PlaceholderText = Placeholder
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)

TextBox.FocusLost:Connect(function(enterPressed)
	if not enterPressed then return end

	local code = TextBox.Text
	if code == "" then return end

	local result = RedeemCode:InvokeServer(code)

	if result and result.success then
		TextBox.Text = ""
	else
		TextBox.Text = code
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	end

	task.delay(3, function()
		if TextBox.Text == code then
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.PlaceholderText = Placeholder
		end
	end)
end)

TextBox.Focused:Connect(function()
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end)
