function onTouched(hit)
	local human = hit.Parent:findFirstChild("NPC")
	if human then
	local anim = human:LoadAnimation(script.Parent.Animation)
	anim:Play()
	end
end
script.Parent.Touched:connect(onTouched)