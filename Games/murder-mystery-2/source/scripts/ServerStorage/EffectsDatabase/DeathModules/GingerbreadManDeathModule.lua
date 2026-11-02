return function(rag)
	if rag ~= nil then
		for _,v in pairs(rag:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") then
				v:Destroy()
			end
		end
		if rag:FindFirstChildOfClass("Humanoid") then
			local des = script.HumanoidDescription:Clone()
			rag.Humanoid:ApplyDescription(des)
		end
		local sound = script.Sound:Clone()
		sound:Play()
		sound.Parent = rag.UpperTorso
	end	
end