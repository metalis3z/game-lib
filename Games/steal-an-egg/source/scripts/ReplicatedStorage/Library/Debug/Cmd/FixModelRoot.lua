-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Selection = game:GetService("Selection")

game:GetService("ChangeHistoryService")

for i, v in ipairs(Selection:Get()) do
	if v:IsA("Model") then
		local RootPart = v:FindFirstChild("HumanoidRootPart")

		if RootPart then
			local v1 = v:FindFirstChildWhichIsA("Humanoid")

			if v1 then
				v1.Parent = nil
			end

			RootPart.Name = "RootPart"

			local _, v2 = v:GetBoundingBox()

			RootPart.Position = RootPart.Position - Vector3.new(0, v2.Y / 2, 0)
		end
	end
end