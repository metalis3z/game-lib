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
	Name = "Pastel Paper",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://131131876870265"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://84249013849465"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://131131876870265"

		for k, v in pairs(game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone():GetChildren()) do
			if v:IsA("MeshPart") then
				for k2, v2 in pairs(v:GetChildren()) do
					if v2:IsA("MeshPart") then
						local Weld = Instance.new("Weld")

						v.Parent = p1:WaitForChild(v.Name)
						Weld.Parent = v
						Weld.Part0 = v
						Weld.Part1 = p1:WaitForChild(v.Name)
						v.Anchored = false
						p1:WaitForChild(v.Name).Transparency = 1
					end
				end
			end
		end
	end,
	UseAbility = function(p1) --[[ UseAbility | Line: 48 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.Transparency = 1

				continue
			end

			if v:IsA("RopeConstraint") then
				v.Color = BrickColor.new("Lily white")
			end
		end

		local GoobSkin = script.Base:Clone()

		GoobSkin.Name = "GoobSkin"
		GoobSkin.Parent = p1.PrimaryPart
		GoobSkin.CFrame = p1.PrimaryPart.CFrame
		GoobSkin.Anchored = false

		local Weld = Instance.new("Weld")

		Weld.Parent = GoobSkin
		Weld.Part0 = GoobSkin
		Weld.Part1 = p1.PrimaryPart
	end
}