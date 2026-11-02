-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage.Library
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local FuncWrapper = require(ReplicatedStorage.Library.Modules.FuncWrapper)
local GUI = require(Library.Client.GUI)
local Variables = require(Library.Variables)
local TabController = require(Library.Client.TabController)
local Tween = require(Library.Functions.Tween)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new():LimitUnderLevel("Warning")
local HideUI = Variables.Locks.HideUI
local v2 = GUI.SideButtons()
local v3 = GUI.FriendBoost()
local v4 = GUI.Money()
local Money = v4.Bottom.Frame.Money
local FriendBoost = v4.Bottom.Frame.FriendBoost
local v5 = GUI.Backpack()
local v6 = GUI.OfflineMoneyInPlot()
local t = {}

t.__index = t
t.__class = "HideImportantUI"
function t._build() --[[ _build | Line: 65 | Upvalues: t (copy), FuncWrapper (copy), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy) ]]
	local v22 = setmetatable({}, t)

	v22._funcWrapper = FuncWrapper.CreateWrapper(v22)
	v22.UiConfig = {
		[v2] = true,
		[v3] = true,
		[v4] = true,
		[v5] = true,
		[v6] = true
	}
	v22:_init()

	return v22
end
function t.SlideInUI(p1, p2) --[[ SlideInUI | Line: 86 | Upvalues: Tween (copy) ]]
	local v1 = p1.UiConfig[p2]

	if type(v1) == "boolean" then
		if v1 then
			p2.Enabled = true
		end
	else
		p2.Enabled = true

		for k, v in pairs(v1.frames) do
			if v.disableOnly then
				k.Visible = true

				continue
			end

			k.Position = v.goalPosition
			Tween(k, {
				Position = v.returnPosition
			}, { 0.4, "Back", "Out" })
		end
	end
end
function t.SlideOutUI(p1, p2) --[[ SlideOutUI | Line: 107 | Upvalues: Tween (copy) ]]
	local v1 = p1.UiConfig[p2]

	if type(v1) == "boolean" then
		if v1 then
			p2.Enabled = false
		end
	else
		for k, v in pairs(v1.frames) do
			if v.disableOnly then
				k.Visible = false

				continue
			end

			Tween(k, {
				Position = v.goalPosition
			}, { 0.4, "Back", "In" }).Completed:Once(function() --[[ Line: 121 | Upvalues: p2 (copy) ]]
				p2.Enabled = false
			end)
		end
	end
end
function t._updateUIVisibility(p1) --[[ _updateUIVisibility | Line: 128 | Upvalues: Variables (copy), HideUI (copy), TabController (copy) ]]
	local Locks = Variables.Locks

	for k, v in pairs(p1.UiConfig) do
		local v1 = HideUI:IsUnlocked() and Locks.HideUIAllowNotifications:IsUnlocked()
		local Enabled = k.Enabled

		if type(v) ~= "boolean" then
			local config = v.config

			if config and config.extraRequirements then
				v1 = if v1 then config.extraRequirements() else v1
			end

			Enabled = assert(next(v.frames), "Empty frame list").Visible
		end

		if Enabled and not v1 then
			p1:SlideOutUI(k)

			continue
		end

		if not Enabled and v1 then
			p1:SlideInUI(k)
		end
	end

	if not HideUI:IsLocked() then
		return
	end

	TabController.CloseTab()
end
function t.IsLocked(p1) --[[ IsLocked | Line: 157 | Upvalues: HideUI (copy) ]]
	return HideUI:IsLocked()
end
function t.IsUnLocked(p1) --[[ IsUnLocked | Line: 161 | Upvalues: HideUI (copy) ]]
	return HideUI:IsUnlocked()
end
function t.Hide(p1) --[[ Hide | Line: 165 | Upvalues: HideUI (copy), v1 (copy) ]]
	HideUI:ObtainLock()
	task.spawn(p1._updateUIVisibility, p1)
	v1:AtTrace():Log((("Hiding UI: %*"):format(HideUI._obtainedCount)))

	return HideUI:IsLocked()
end
function t.UnHide(p1) --[[ UnHide | Line: 175 | Upvalues: wcall (copy), HideUI (copy), v1 (copy) ]]
	wcall(HideUI.ReleaseLock, HideUI)
	task.spawn(p1._updateUIVisibility, p1)
	v1:AtTrace():Log((("Uniding UI: %*"):format(HideUI._obtainedCount)))

	return HideUI:IsUnlocked()
end
function t._init(p1) --[[ _init | Line: 189 ]]
	return p1
end

return t._build()