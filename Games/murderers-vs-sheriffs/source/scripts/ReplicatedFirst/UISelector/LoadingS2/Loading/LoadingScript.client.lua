-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game.Players.LocalPlayer
local v2 = game.ReplicatedFirst
local v_u_3 = game.StarterGui
v2:RemoveDefaultLoadingScreen()
v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
local v_u_4 = script.Parent
local v5 = v_u_4:WaitForChild("Main")
local v6 = v_u_4:WaitForChild("Main"):WaitForChild("Container")
local v7 = v6:WaitForChild("Color")
local v_u_8 = v6:WaitForChild("Grey")
local v9 = game:GetService("TweenService")
local v10 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local v_u_11 = v9:Create(v5, v10, {
	["BackgroundTransparency"] = 1
})
local v_u_12 = v9:Create(v7, v10, {
	["ImageTransparency"] = 1
})
local v_u_13 = false
local function v_u_14()
	-- upvalues: (copy) v_u_12, (copy) v_u_11, (copy) v_u_4, (copy) v_u_3
	v_u_12:Play()
	v_u_11:Play()
	task.wait(0.5)
	v_u_4.Enabled = false
	v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, true)
	v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.Captures, true)
	v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.SelfView, true)
end
(function()
	-- upvalues: (ref) v_u_13, (copy) v_u_3, (copy) v_u_1, (copy) v_u_8, (copy) v_u_14
	task.spawn(function()
		-- upvalues: (ref) v_u_13, (ref) v_u_3
		while task.wait() and not v_u_13 do
			v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		end
	end)
	repeat
		task.wait()
	until v_u_1.Character ~= nil
	v_u_8.Visible = false
	task.wait(1)
	v_u_14()
	v_u_13 = true
	game.StarterGui:WaitForChild("NewUI2025").Enabled = true
	game.Players.LocalPlayer.PlayerGui:WaitForChild("NewUI2025").Enabled = true
end)()