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
-- CQNNBEhlYWQORmluZEZpcnN0Q2hpbGQQSHVtYW5vaWRSb290UGFydAdOYW1lVGFnDFdhaXRGb3JDaGlsZApCdWJibGVDaGF0D05hbWVUYWdPdmVycmlkZQVWYWx1ZQdBZG9ybmVlDWhhbmRsZU5hbWVUYWcFcGFpcnMOR2V0RGVzY2VuZGFudHMITWVzaFBhcnQDSXNBG3JieGFzc2V0aWQ6Ly84OTM4MTg0MTM2MTI3NwlUZXh0dXJlSUQIU2tpblBhcnQGSGFzVGFnCVJlbW92ZVRhZw1Db2xvclNlcXVlbmNlA25ldxVDb2xvclNlcXVlbmNlS2V5cG9pbnQGQ29sb3IzB2Zyb21SR0IOQWx0ZXJuYXRlQ29sb3IMU2V0QXR0cmlidXRlCVRvb25MaWdodApQb2ludExpZ2h0BUNvbG9yCkV4dHJhTGlnaHQGQ29uZmlnDEJsaW5rVGV4dHVyZQtIdXJ0VGV4dHVyZQ1Ob3JtYWxUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMzg4MTY4NTQwNjk3MjMHVGV4dHVyZRxyYnhhc3NldGlkOi8vMTI3MzI2NzMxMzA4OTcxBGdhbWUNU2VydmVyU3RvcmFnZRBTa2luTW9kZWxTdG9yYWdlCk1vZHVsZU5hbWUGc2NyaXB0BE5hbWUFQ2xvbmUEcm9vdAhSb290UGFydAdEZXN0cm95BlBhcmVudApBbmltYXRpb25zC0dldENoaWxkcmVuCUFuaW1hdGlvbgtBbmltYXRpb25JZA5SaWdodFVwcGVyckFybQ1SaWdodFVwcGVyQXJtClVwcGVyVG9yc28FVG9yc28ISW5zdGFuY2UEV2VsZAVQYXJ0MAVQYXJ0MQhBbmNob3JlZAxUcmFuc3BhcmVuY3kEdGFzawVzcGF3bgZEZWJyaXMKR2V0U2VydmljZQdBZGRJdGVtCUFwcGx5U2tpbhFDb2xsZWN0aW9uU2VydmljZQxCcmlzayBCcmVlemUGQ29ubmllCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQpEYW5keVN0b3JlBENvc3QAAwcBAAAAADVvAwAAvAEAAwEAAACfAQMCKwEBAIIAAQBvBAIAvAIAAwEAAACfAgMCKwIBAIIAAQBvBQMAjAYFALwDAtME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

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")

return {
	Name = "Brisk Breeze",
	TowerName = "Connie",
	Description = "No description yet",
	Mastery = false,
	DandyStore = true,
	Cost = 600,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 12 | Upvalues: CollectionService (copy) ]]
		local function handleNameTag(p1) --[[ handleNameTag | Line: 14 ]]
			local Head = p1:FindFirstChild("Head")

			if not Head then
				return
			end

			local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

			if not HumanoidRootPart then
				return
			end

			local NameTag = HumanoidRootPart:WaitForChild("NameTag", 5)

			if not NameTag then
				return
			end

			if not Head:FindFirstChild("BubbleChat") then
				NameTag.Adornee = Head

				return
			end

			local NameTagOverride = Head.BubbleChat:FindFirstChild("NameTagOverride")

			if NameTagOverride then
				local _ = NameTagOverride.Value == nil
			end

			NameTag.Adornee = Head.BubbleChat
		end

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://89381841361277"
			end

			if CollectionService:HasTag(v, "SkinPart") then
				CollectionService:RemoveTag(v, "SkinPart")
			end
		end

		p1:SetAttribute("AlternateColor", (ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(203, 186, 145)), ColorSequenceKeypoint.new(1, Color3.fromRGB(203, 186, 145)) })))
		p1.HumanoidRootPart.ToonLight.PointLight.Color = Color3.fromRGB(203, 186, 145)
		p1.HumanoidRootPart.ExtraLight.PointLight.Color = Color3.fromRGB(203, 186, 145)

		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://138816854069723"
		HurtTexture.Texture = "rbxassetid://127326731308971"
		NormalTexture.Texture = "rbxassetid://89381841361277"

		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()

		p1.RootPart.root:Destroy()
		v1.RootPart.root.Parent = p1.RootPart

		local Animations = p1:WaitForChild("Animations")

		for k, v in pairs(v1:WaitForChild("Animations"):GetChildren()) do
			local v2 = Animations:FindFirstChild(v.Name)

			if v2 and (v2:IsA("Animation") and v:IsA("Animation")) then
				v2.AnimationId = v.AnimationId
			end
		end

		local t = {
			RightUpperArm = "RightUpperrArm",
			Torso = "UpperTorso"
		}

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("MeshPart") then
				local Weld = Instance.new("Weld")
				local v4 = p1:WaitForChild(t[v.Name] or v.Name)

				v.Parent = v4
				Weld.Parent = v
				Weld.Part0 = v
				Weld.Part1 = v4
				v.Anchored = false
				v4.Transparency = 1
			end
		end

		task.spawn(handleNameTag, p1)
		game:GetService("Debris"):AddItem(v1, 10)
	end
}