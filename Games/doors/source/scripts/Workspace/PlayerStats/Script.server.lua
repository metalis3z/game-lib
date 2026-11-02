for i, v in pairs(script.Parent.Parent:GetDescendants()) do
	if v:IsA("Folder") and v:GetAttribute("FirstRoomLoaded", false or true) then
		print("Cabel")
		v:Destroy()
	end
end