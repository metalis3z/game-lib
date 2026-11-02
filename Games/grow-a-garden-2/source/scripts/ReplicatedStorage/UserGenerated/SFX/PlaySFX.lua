--credit to leon games studio
return function(p1, p2, p3) --[[ PlaySFX | Line: 20 ]]
	local Attachment = Instance.new("Attachment")

	Attachment.CFrame = p1.CFrame:ToObjectSpace(p2)
	p3.Parent = Attachment
	Attachment.Parent = p1
	p3.Ended:Connect(function() --[[ Line: 25 | Upvalues: Attachment (copy) ]]
		Attachment:Destroy()
	end)
	p3:Play()
end