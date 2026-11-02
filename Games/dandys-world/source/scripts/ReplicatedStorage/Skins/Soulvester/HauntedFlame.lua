--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
return {
	Name = "Haunted Flame",
	TowerName = "Soulvester",
	Description = "No description yet",
	Halloween = true,
	HolidaySkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 11 ]]
		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()
		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://119853473353111"
		HurtTexture.Texture = "rbxassetid://128243972325841"
		NormalTexture.Texture = "rbxassetid://75387101103288"

		local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
		local v2 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ToonLight") else HumanoidRootPart
		local v3 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ExtraLight") else HumanoidRootPart
		local v4 = if v2 then v2:FindFirstChild("PointLight") else v2
		local v5 = if v3 then v3:FindFirstChild("PointLight") else v3

		if v4 then
			v4.Color = Color3.fromRGB(240, 210, 245)
		end

		if v5 then
			v5.Color = Color3.fromRGB(240, 210, 245)
		end

		local t = {}

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("MeshPart") then
				local Weld = Instance.new("Weld")
				local v7 = p1:WaitForChild(t[v.Name] or v.Name)

				v.Parent = v7
				Weld.Parent = v
				Weld.Part0 = v
				Weld.Part1 = v7
				v.Anchored = false
				v7.Transparency = 1
			end
		end

		game:GetService("Debris"):AddItem(v1, 10)
	end
}