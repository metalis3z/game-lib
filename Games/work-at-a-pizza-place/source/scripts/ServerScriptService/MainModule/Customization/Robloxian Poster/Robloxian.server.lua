local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
config = model.Config


local player = house.Owner.Value




local name = nil
if config.Value == 0 then
	local getId =  game.Workspace.MessageService.GetName:InvokeClient(player)
	if getId ~= -1 then
		config.Value = getId
		
	end
end


if config.Value ~= 0 and config.Value ~= -1 then
model.Pic.Pic.Texture = "http://www.roblox.com/Thumbs/Avatar.ashx?x=250&y=250&Format=Png&userid=" .. model.Config.Value
model.name.SG.Label.Text = game.Players:GetNameFromUserIdAsync(model.Config.Value)
end
	
