-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()

return {
	Start = function(p1, p2, p3) --[[ Start | Line: 21 | Upvalues: Asserts (copy), TweenService (copy), v1 (copy) ]]
		Asserts.GuiButton(p1)
		Asserts.Color3(p2)
		Asserts.TweenInfo(p3)

		local ImageColor3 = p1.ImageColor3
		local v12 = TweenService:Create(p1, p3, {
			ImageColor3 = p2
		})
		local v2 = false
		local UIScale = Instance.new("UIScale")

		UIScale.Parent = p1
		UIScale.Scale = 0.9

		local v3 = TweenService:Create(UIScale, p3, {
			Scale = 1.15
		})

		v3:Play()
		v12:Play()
		v1:AtTrace():Log("Started image-color pulse")

		return function() --[[ Line: 43 | Upvalues: v2 (ref), v12 (copy), p1 (copy), ImageColor3 (copy), v3 (copy), UIScale (copy), v1 (ref) ]]
			if v2 then
				return
			end

			v2 = true
			v12:Cancel()
			p1.ImageColor3 = ImageColor3
			v3:Cancel()
			UIScale.Scale = 1

			if not UIScale:GetAttribute("ButtonFXOwned") then
				UIScale:Destroy()
			end

			v1:AtTrace():Log("Cleared image-color pulse")
		end
	end
}