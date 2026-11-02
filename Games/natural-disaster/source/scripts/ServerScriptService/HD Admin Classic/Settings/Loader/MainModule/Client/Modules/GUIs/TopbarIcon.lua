-- LOCAL
local main = _G.HDAdminMain
local playerGui = main.playerGui
local replicatedStorage = game:GetService("ReplicatedStorage")
local hdDirectory = replicatedStorage:FindFirstChild("HDAdmin")
local topbarPlus = hdDirectory and hdDirectory:FindFirstChild("Topbar+")

-- This allows for backwards compatibility with v1 until Nanoblox is released
if topbarPlus then
	local iconController = require(topbarPlus.IconController)
	local hdIcon = iconController:createIcon("HDAdmin", 4882428756, 0)
	hdIcon:setToggleMenu(main.gui.MainFrame)
	return hdIcon
end

-- Now use TopbarPlus as normal
local topbarPlus = main.client.Assets.Icon
local Icon = require(topbarPlus)
local hdIcon = Icon.new()
	:setImage(4882428756, "deselected")
	:setImage(6326373239, "selected")
	:setImageScale(0.6, "deselected")
	:setImageScale(0.5, "selected")
	:bindToggleItem(main.gui.MainFrame)
	:setOrder(0)
	
-- This ensures the icon is hidden if not permitted rank
task.defer(function()
	main:GetModule("cf"):RankChangedUpdater()
end)

return hdIcon