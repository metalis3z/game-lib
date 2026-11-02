return function(Knife)
	local Clone = script.Electric:Clone()
	Clone.Parent = Knife.Handle
	if Knife.Handle:FindFirstChild("EffectCenter") then
		for i,v in pairs(Knife.Handle:GetChildren()) do
			if v:IsA("BillboardGui") then
				v.Parent = Knife.Handle.EffectCenter;
			end
		end
	end
end