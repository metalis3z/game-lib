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
	Name = "Show-Time Razzle & Dazzle",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 9 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://139433206714470"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://129664097040703"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://139433206714470"
		BlinkTexture.Texture = "rbxassetid://112800906548287"

		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("MeshPart") then
				if v.Name == "Hat" then
					local Weld = Instance.new("Weld")

					v.Parent = p1:WaitForChild("Head")
					Weld.Parent = v
					Weld.Part0 = v
					Weld.Part1 = p1:WaitForChild("Head")
					v.Anchored = false

					continue
				end

				local Weld = Instance.new("Weld")

				v.Parent = p1:WaitForChild(v.Name)
				Weld.Parent = v
				Weld.Part0 = v
				Weld.Part1 = p1:WaitForChild(v.Name)
				v.Anchored = false
				p1:WaitForChild(v.Name).Transparency = 1
			end
		end

		p1.RootPart.root:Destroy()
		v1.RootPart.root.Parent = p1.RootPart
		p1.Animate.Enabled = false
		p1.Animate.Enabled = true
		game:GetService("Debris"):AddItem(v1, 10)
	end
}