
local toolName = script.Parent.Parent.ToolValue.Value
local count = script.Parent.Parent.Count.Value
local amount = script.Parent.Parent.Amount.Value
counter = amount
local GroupID = 16324260
local GroupRank = 4

function onMouseClick(player)
	if player:IsInGroup(GroupID) and player:GetRankInGroup(GroupID) >= GroupRank and player.Team == game.Teams.Police then
		if player.Backpack:FindFirstChild(toolName) == nil then
	if script.Parent.Parent.Count.Value > 0 then
				local tool = game.ServerStorage.PoliceTools[toolName]:Clone()
		tool.Parent = player.Backpack
		script.Parent.Parent.Count.Value = script.Parent.Parent.Count.Value - 1
		script.Parent.Parent.Surface.SurfaceGui.TextLabel.Text = tostring(script.Parent.Parent.Count.Value).."/"..tostring(amount)
		--script.Parent.Parent.BillboardGui.TextLabel.Text = tostring(count).."/20"
	end
		end
	end
	end
script.Parent.MouseClick:connect(onMouseClick)