
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local t1 = {
	"idle",
	"walk",
	"run",
	"swim",
	"swimidle",
	"jump",
	"fall",
	"climb",
	"sit",
	"toolnone",
	"toolslash",
	"toollunge",
	"wave",
	"point",
	"dance",
	"dance2",
	"dance3",
	"laugh",
	"cheer"
}
local t5 = {
	GetCharacter = function(_: {[any]: any}, p1)
		if RunService:IsServer() then
			if not p1 then
				return nil
			end
		else
			p1 = p1 or Players.LocalPlayer
		end

		local Character = p1.Character

		if not Character then
			return nil
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return nil
		end

		local Humanoid = Character:FindFirstChild("Humanoid")

		if not Humanoid then
			return nil
		end

		return Character, HumanoidRootPart, Humanoid
	end,
	SetAnimations = function(_: {[any]: any}, p2, s1: string, t4: {[any]: any}?)
		local Animate = p2:FindFirstChild("Animate")

		if not Animate then
			return
		end

		local s1_2 = Animate:FindFirstChild(s1)

		if not s1_2 then
			return
		end

		local OriginalValues = s1_2:FindFirstChild("OriginalValues")

		if OriginalValues then
			for _, v in ipairs(s1_2:GetChildren()) do
				if v:IsA("Animation") then
					v:Destroy()
				end
			end

			for _, v in ipairs(OriginalValues:GetChildren()) do
				v.Parent = s1_2
			end

			OriginalValues:Destroy()
		end

		if t4 then
			local Folder = Instance.new("Folder")

			for _, v in ipairs(s1_2:GetChildren()) do
				v.Parent = Folder
			end

			Folder.Name = "OriginalValues"
			Folder.Parent = s1_2

			for _, v in ipairs(t4) do
				v:Clone().Parent = s1_2
			end
		end
	end
}

function t5.RevertAnimations(_: {[any]: any}, p3, s2: string)
	t5:SetAnimations(p3, s2, nil)
end
function t5.RevertAllAnimations(_: {[any]: any}, p4)
	for _, v in ipairs(t1) do
		t5:RevertAnimations(p4, v)
	end
end

return t5
