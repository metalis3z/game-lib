-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Library.Client.GUI)

require(ReplicatedStorage.Library.Types.GUI)

local Player = require(ReplicatedStorage.Library.Player)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local v1 = GUI.Money()
local Money = v1.Bottom.Frame.Money
local FriendBoost = v1.Bottom.Frame.FriendBoost
local TopBar = GUI.OfflineMoneyInPlot().TopBar
local v2 = GUI.TopBarStandard()
local v3 = GUI.Backpack()
local v4 = GUI.SideButtons()
local Tools = v4.Left.Tools
local TreadmillSpeedShop = Tools.TreadmillSpeedShop
local DoubleYourSpeed = Tools.DoubleYourSpeed
local Right = v4.Right
local Tabs = v4.Tabs
local t = {}

for i, v in ipairs(Tools:GetChildren()) do
	if v:IsA("GuiObject") then
		t[#t + 1] = v

		continue
	end

	if v:IsA("Folder") then
		for i2, v5 in ipairs(v:GetChildren()) do
			if v5:IsA("GuiObject") then
				t[#t + 1] = v5
			end
		end
	end
end

local v5 = nil

return {
	Apply = function(p1) --[[ Apply | Line: 67 | Upvalues: v5 (ref), t (copy), v3 (copy), FriendBoost (copy), Money (copy), Right (copy), Tabs (copy), TopBar (copy), v2 (copy), TreadmillSpeedShop (copy), DoubleYourSpeed (copy), Player (copy), TabController (copy) ]]
		if p1 then
			if v5 == nil then
				local t2 = {}

				for i, v in ipairs(t) do
					t2[v] = v.Visible
				end

				v5 = {
					BackpackEnabled = v3.Enabled,
					FriendBoostVisible = FriendBoost.Visible,
					MoneyVisible = Money.Visible,
					SideButtonsGuiRightVisible = Right.Visible,
					SideButtonTabsVisible = Tabs.Visible,
					ToolVisibility = t2,
					OfflineMoneyInPlotVisible = TopBar.Visible,
					TopBarEnabled = v2.Enabled
				}
			end

			v3.Enabled = false
			Right.Visible = false
			Money.Visible = false
			FriendBoost.Visible = false
			TopBar.Visible = false
			v2.Enabled = false

			local v1 = v5

			assert(v1 ~= nil, "Expected treadmill UI visibility state")

			for k in pairs(v1.ToolVisibility) do
				k.Visible = false
			end

			TreadmillSpeedShop.Visible = true
			DoubleYourSpeed.Visible = true

			local v32 = Player.Optional.Humanoid()

			if v32 == nil then
				return
			end

			v32:UnequipTools()
		else
			if TabController.IsOpen("TreadmillSpeedShop") then
				TabController.CloseTab()
			end

			local v4 = v5

			if v4 == nil then
				return
			end

			v2.Enabled = v4.TopBarEnabled
			TopBar.Visible = v4.OfflineMoneyInPlotVisible
			v3.Enabled = v4.BackpackEnabled
			Money.Visible = v4.MoneyVisible
			FriendBoost.Visible = v4.FriendBoostVisible
			Right.Visible = v4.SideButtonsGuiRightVisible

			for k, v in pairs(v4.ToolVisibility) do
				if k.Parent ~= nil then
					k.Visible = v
				end
			end

			v5 = nil
		end
	end
}