--for halloween candy
local yum = script:WaitForChild("Yum")
yum.Parent = script.Parent

debounce = false
function touched(hit)
	if not debounce and hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player then
			debounce = true
			if player.Character:FindFirstChild("Bucket") then
				local bucket = player.Character.Bucket
				delay(.2,function()
					player.Character.Humanoid:EquipTool(bucket)
				end)
			end

			script.Parent.Parent.Parent = player.Backpack
			
			
			wait(2)
			debounce = false
		end
	end
end
script.Parent.Touched:connect(touched)


function Activated()
	yum:Play()
	wait(.1)
	script.Parent.Parent:Destroy()
end
script.Parent.Parent.Activated:connect(Activated)