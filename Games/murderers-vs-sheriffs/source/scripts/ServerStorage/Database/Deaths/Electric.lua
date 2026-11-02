return function(rag)
	if rag then
		for _, v in pairs(rag:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") then
				v:Destroy()
			end
		end

		if rag:FindFirstChildOfClass("Humanoid") then
			local humanoid = rag.Humanoid
			local des = script.HumanoidDescription:Clone()
			humanoid:ApplyDescription(des)
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end
		for _, part in pairs(rag:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CollisionGroup = "PlayerNoCollision"
			end
		end
		local sound = script.Sound:Clone()
		sound.Parent = rag:FindFirstChild("UpperTorso") or rag.PrimaryPart
		sound:Play()
	end
end
