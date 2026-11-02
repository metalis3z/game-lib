for i,v in script.Parent:GetChildren() do
	if v.Name ~= "AnimationClone" then
		v.Parent = script.Parent.Parent.KnifeClient
	end
end

script.Parent:Destroy()