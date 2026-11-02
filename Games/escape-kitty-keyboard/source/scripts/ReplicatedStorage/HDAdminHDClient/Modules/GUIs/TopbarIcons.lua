

local u1 = _G.HDAdminMain
local _ = u1.playerGui
local v2 = game:GetService("ReplicatedStorage"):FindFirstChild("HDAdmin")
if v2 then
	v2 = v2:FindFirstChild("Topbar+")
end
if v2 then
	local v3 = require(v2.IconController)
	local v4 = v3:createIcon("HDAdmin", 4882428756, 0)
	v4:setToggleMenu(u1.gui.MainFrame)
	return {
		["Dashboard"] = v4,
		["Commands"] = v3:createIcon("HDCommands", 81506631564371, 0)
	}
else
	local v5 = u1.client.Assets.Icon
	local u6 = u1.gui.MainFrame
	local v7 = require(v5)
	return {
		["Dashboard"] = v7.new():setImage(139559302589584, "deselected"):setImage(90888779036359, "selected"):setImageScale(0.45, "deselected"):setImageScale(0.45, "selected"):bindToggleItem(u6):setOrder(0):setEnabled(false),
		["Commands"] = v7.new():setImage(81506631564371, "deselected"):setImage(111054392340110, "selected"):setImageScale(0.55, "deselected"):setImageScale(0.55, "selected"):bindEvent("selected", function()

			task.defer(function()

				u6.Visible = true
				u1:GetModule("GUIs"):ShowSpecificPage("Commands", "Commands", true, nil, true)
			end)
		end):bindEvent("deselected", function()

			u6.Visible = false
		end):setOrder(0):setEnabled(false)
	}
end