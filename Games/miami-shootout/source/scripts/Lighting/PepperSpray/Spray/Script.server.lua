local db = false

function onTouched(hit)
local h = hit.Parent:findFirstChild("Humanoid")
if h ~= nil then
		if game.Players:FindFirstChild(hit.Parent.Name) ~= nil and db == false then
			local plr = game.Players:FindFirstChild(hit.Parent.Name)
			
			local npcLook = plr.Character:FindFirstChild("Head").CFrame.LookVector
			local npcToChar = (plr.Character:FindFirstChild("Head").Position - script.Parent.Parent.Parent.PrimaryPart.Position).Unit
			local dotProduct = npcToChar:Dot(npcLook)
			if dotProduct < .5 then
				--print("can see",dotProduct)
				db = true
				game.ReplicatedStorage.Pepper:Fire(game.Players:FindFirstChild(hit.Parent.Name))
				delay(3,function()
					db = false
				end)
			else
				--print("cant see",dotProduct)
			end	
	end
		
end
end
script.Parent.Touched:connect(onTouched)
