-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = script.Parent:WaitForChild("Game"):WaitForChild("Knife")
local v2 = script.Parent:WaitForChild("Game"):WaitForChild("Gun")
local function v_u_9(p3)
	local v4 = game.Players.LocalPlayer.Backpack
	if v4 then
		local v5 = game.Players.LocalPlayer.Character
		if v5 then
			local v6 = v5:FindFirstChildOfClass("Humanoid")
			if v6 then
				for _, v7 in v4:GetChildren() do
					if v7:HasTag(p3) and v7:IsA("Tool") then
						v6:EquipTool(v7)
						return
					end
				end
				for _, v8 in v5:GetChildren() do
					if v8:HasTag(p3) and v8:IsA("Tool") then
						v6:UnequipTools()
						return
					end
				end
			end
		else
			return
		end
	else
		return
	end
end
v1.MouseButton1Click:Connect(function()
	v_u_9("Weapon_Knife")
end)
v2.MouseButton1Click:Connect(function()
	v_u_9("Weapon_Gun")
end)