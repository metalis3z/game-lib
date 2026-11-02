
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local mutationData = require(ReplicatedStorage.Datas.Mutations)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local ButtonFX = require(script.Parent.ButtonFX)
local UnlockIndexRemote = Net:RemoteFunction("AdminService/UnlockIndex")
local Index = script.Parent.Index.Frame
local mainNameLabel = Index.mainName

local UnlockButton = AnimatedButton.new(Index.Unlock)
UnlockButton:Animate()
UnlockButton.OnActivated:Connect(function()
	local success, message = UnlockIndexRemote:InvokeServer(mainNameLabel.Text)
	if not success then
		NotificationController:Error(message)
	end
end)

local mutationList = {
	["All"] = {
		["DisplayName"] = "All",
		["DisplayWithRichText"] = "<font color=\"#FFFFFF\">All</font>",
		["Icon"] = "http://www.roblox.com/asset/?id=11157772247",
		["Color"] = Color3.fromRGB(85, 170, 0)
	}
}
for v17, v18 in pairs(mutationData) do
	mutationList[v17] = v18
	mutationList[v17].DisplayName = v17
	mutationList[v17].Color = v18.MainColor
end

script.Parent.Index.Frame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(mutationList, function(selectedMutation)
		script.Parent.Index.Frame.mainName.Text = selectedMutation
	end)
end)
