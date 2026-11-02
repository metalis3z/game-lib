-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:19
-- Luau version 6, Types version 3
-- Time taken: 0.004529 seconds

local any_GetPlayerFromCharacter_result1_2 = game.Players:GetPlayerFromCharacter(script.Parent)
if any_GetPlayerFromCharacter_result1_2 then
	local PlayerGui = any_GetPlayerFromCharacter_result1_2:FindFirstChild("PlayerGui")
	if PlayerGui and PlayerGui:FindFirstChild("DarknessGui") == nil then
		local ScreenGui_2 = Instance.new("ScreenGui")
		ScreenGui_2.Name = "DarknessGui"
		ScreenGui_2.Parent = PlayerGui
		local Frame_2 = Instance.new("Frame")
		Frame_2.Name = "DarknessFrame"
		Frame_2.Size = UDim2.new(1, 0, 1, 0)
		Frame_2.Position = UDim2.new(0, 0, 0, 0)
		Frame_2.BackgroundTransparency = 1
		Frame_2.Parent = ScreenGui_2
		local ImageLabel_2 = Instance.new("ImageLabel")
		ImageLabel_2.Image = "http://www.roblox.com/asset/?id=68915275"
		ImageLabel_2.BackgroundTransparency = 1
		ImageLabel_2.Position = UDim2.new(0, 0, 0, 0)
		ImageLabel_2.Size = UDim2.new(1, 0, 1, 0)
		ImageLabel_2.Parent = Frame_2
		while 0 < 2.5 do
			wait()
		end
		if ScreenGui_2 then
			ScreenGui_2:Remove()
		end
		wait(2.5)
		script:Remove()
	end
end
wait(2)
if script then
	script:Remove()
end