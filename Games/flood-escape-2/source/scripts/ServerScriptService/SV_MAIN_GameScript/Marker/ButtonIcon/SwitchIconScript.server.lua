repeat wait() until script.Parent ~= nil

if script.Parent.Image == "rbxassetid://2192707404" then
	while task.wait(2) do
		if script.Parent ~= nil then
			if script.Parent.ImageRectOffset == Vector2.new(128, 0) then
				script.Parent.ImageRectOffset = Vector2.new(0, 0)
			else
				script.Parent.ImageRectOffset = Vector2.new(128, 0)
			end	
		end
	end
end