local module = {}

function module:PlayerAttribute(p1)
	local room = p1
	
	if room:FindFirstChild("CollideRoom") then
		local collide = room:FindFirstChild("CollideRoom")
		
		game:GetService("RunService").Heartbeat:Connect(function()
			for i, v in pairs(workspace:GetPartsInPart(collide)) do
				if v.Name == "HumanoidRootPart" then
					local Parent = v.Parent
					local PlayerRef = game.Players:GetPlayerFromCharacter(Parent)
					if PlayerRef then
						PlayerRef.Character:SetAttribute("CurrentRoom", room.Name)
					end
				end
			end
		end)
	end
end

return module
