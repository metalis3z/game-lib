local l_Players_0 = game:GetService("Players")
local l_RunService_0 = game:GetService("RunService")
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage")
local _ = l_ReplicatedStorage_0:WaitForChild("Models").ToolsExtras
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages")
local v5 = require(l_Packages_0.Net)
local _ = require(l_Packages_0.Debounce)
local l_Parent_0 = script.Parent
local l_Parent_1 = l_Parent_0.Parent.Parent
local l_MainHighlight_0 = workspace:WaitForChild("MainHighlight")
local v10 = nil

local function v20()
	local l_Character_0 = l_Parent_1.Character
	if not l_Character_0 then return end

	local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart")
	if not l_HumanoidRootPart_0 then return end

	local v13 = nil
	local v14 = 1e999

	for _, v16 in l_Players_0:GetPlayers() do
		if v16 ~= l_Parent_1 and v16.Name ~= "Abderrlol" then
			local l_Character_1 = v16.Character
			local v18 = l_Character_1 and l_Character_1:FindFirstChild("HumanoidRootPart")

			if v18 then
				local dist = (l_HumanoidRootPart_0.Position - v18.Position).Magnitude
				if dist <= 30 and dist < v14 then
					v14 = dist
					v13 = l_Character_1
				end
			end
		end
	end

	return v13, l_Players_0:GetPlayerFromCharacter(v13)
end

l_Parent_0.Activated:Connect(function()
	v5:RemoteEvent("UseItem"):FireServer(v10)
end)

l_Parent_0.Equipped:Connect(function()
	l_RunService_0:UnbindFromRenderStep("BeeTarget")
	l_MainHighlight_0.Adornee = script
	v10 = nil

	l_RunService_0:BindToRenderStep("BeeTarget", Enum.RenderPriority.Character.Value + 1, function()
		if l_Parent_0:GetAttribute("CooldownTime") then
			l_MainHighlight_0.Adornee = script
			v10 = nil
			return
		end

		local v21, v22 = v20()

		if v21 and v21 ~= v10 then
			l_MainHighlight_0.Adornee = v21
			v10 = v22
		else
			l_MainHighlight_0.Adornee = script
			v10 = nil
		end
	end)
end)

l_Parent_0.Unequipped:Connect(function()
	l_RunService_0:UnbindFromRenderStep("BeeTarget")
	l_MainHighlight_0.Adornee = script
	v10 = nil
end)