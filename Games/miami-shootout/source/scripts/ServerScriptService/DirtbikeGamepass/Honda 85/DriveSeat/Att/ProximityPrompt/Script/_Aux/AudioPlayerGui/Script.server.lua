local Toggled = false
local playerlist = script.Players.Value
function update()
	local myname = script.Parent.Parent.Parent.Parent.Name
	local children = playerlist:GetChildren()
	for i = 1, #children do
		local child = children[i]
--		child:Destroy()
		if  not script.Parent.List.ScrollingFrame:FindFirstChild(child.Name) then
			local tagger = script.Parent.List.Box:Clone()
			tagger.Parent = script.Parent.List.ScrollingFrame
			tagger.Name = child.Name
			local plronlist = game.Players:FindFirstChild(child.Name)
			tagger.TextButton.Text = plronlist.CharacterStats.FirstName.Value.." "..plronlist.CharacterStats.LastName.Value.." ("..child.Name..")"

			
		end
		if not playerlist:FindFirstChild(child.Name) then
			script.Parent.List.ScrollingFrame:FindFirstChild(child.Name):Destroy()
			
		end
		if   script.Parent.List.ScrollingFrame:FindFirstChild(myname) then
			script.Parent.List.ScrollingFrame:FindFirstChild(myname):Destroy()
			
			
			
		end
	end
	
end




script.Parent.Aux.TextButton.MouseButton1Click:Connect(function()

	update()
	if Toggled == false then
		Toggled = true
		
		script.Parent.List.Visible = true
	elseif Toggled == true then
		Toggled = false
		script.Parent.List.Visible = false
	end
end)