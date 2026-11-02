local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

model.Sign.SG:WaitForChild("name")
model:WaitForChild("Config")
config = model.Config
name = model.Sign.SG.name


local player = house.Owner.Value


if config.Value == "" then
	wait(.5)
	local getString =  game.Workspace.MessageService.GetString:InvokeClient(player)
	if getString ~= "-1" then
		config.Value = getString
	end
end


name.Text = config.Value

wait()

workspace.Main.FilterPlayerText:FireAllClients(player,config,"Value")



	
