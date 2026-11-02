local Tool = script.Parent.Parent.Parent:FindFirstChild('Tool').Value
local MaxUses = script.Parent.Parent.Parent:FindFirstChild('MaxUses')
local Cooldown = script.Parent.Parent.Parent:FindFirstChild('Cooldown').Value
if not game:FindService('ServerStorage'):FindFirstChild(Tool) then return end

local Uses = nil
if MaxUses then
	Uses = Instance.new('NumberValue', MaxUses.Parent)
	Uses.Value = MaxUses.Value
	Uses.Name = 'Uses'
end

if not game:FindService('ServerStorage'):FindFirstChild(Tool) or Uses == nil then return end

script.Parent.Parent.Parent:FindFirstChild('BillboardGui'):FindFirstChild('The').Text = string.upper(Tool) .. ' CRATE'
script.Parent.Parent.Parent:FindFirstChild('BillboardGui'):FindFirstChild('Uses').Text = tostring(Uses.Value) .. '/' .. tostring(MaxUses.Value)
script.Parent.ObjectText = Tool

script.Parent.Triggered:Connect(function(Player)
	if Player and Player.Character and Player.Character:FindFirstChild('Humanoid') and Player.Character:FindFirstChild('HumanoidRootPart') and Player:FindFirstChild('stored'):FindFirstChild('Gang') then
		if MaxUses and Uses then
			if Player:IsInGroup(14692389) then
				if Uses.Value > 0 then
					if Player:GetRankInGroup(14692389) >= 12 then
						Uses.Value -= 1
						script.Parent.Parent.Parent:FindFirstChild('BillboardGui'):FindFirstChild('Uses').Text = tostring(Uses.Value) .. '/' .. tostring(MaxUses.Value)
						local TOOL = game:FindFirstChild('ServerStorage'):FindFirstChild(Tool):Clone() TOOL.Parent = Player:FindFirstChild('Backpack') 
						game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Collected a ' .. Tool .. '.', 2)
						task.spawn(function()
							task.wait(Cooldown)
							Uses.Value += 1
							script.Parent.Parent.Parent:FindFirstChild('BillboardGui'):FindFirstChild('Uses').Text = tostring(Uses.Value) .. '/' .. tostring(MaxUses.Value)
						end)
					else
						game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Not high enough rank.', 2)
					end
				else
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'No uses left on this crate.', 2)
				end
			end
		else
			game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You arent in this group.', 2)
		end
	end
end)