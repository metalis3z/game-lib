local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

dj = model.Dj

local colors = {Color3.new(0,255/255,0),Color3.new(255/255,0,0),Color3.new(0,0,255/255),Color3.new(255/255,255/255,0),Color3.new(0,255/255,255/255),Color3.new(255/255,0,255/255)}
current_phones = nil


workspace.Main.AssetIdChanged.OnServerEvent:connect(function(player,object,newId)
	if object == model and player == dj.Value  then
		model.Config.Value = newId
	end
end)



function click(clicker)
	if dj.Value == nil then
		dj.Value = clicker
		model.DjName.Coiner.TextLabel.Text = "DJ " .. dj.Value.Name
		Dialog:ShowMessage(clicker,"DJ","You are now the DJ!","Ok") 
		current_phones = game.ReplicatedStorage["DJ Headphones"]:clone()
		current_phones.Parent = clicker.Character
	end
	if clicker == dj.Value then
		workspace.Main.OpenAssetPicker:FireClient(clicker,model,"Audio")
		
	elseif dj.Value ~= nil then
		Dialog:ShowMessage(clicker,"DJ",dj.Value.Name .. " is the current DJ. Only the DJ can change the song.","Ok") 
	end
end
model.ClickDetector.MouseClick:connect(click)






while true do
	wait(5)
	if model.Config.Value ~= 0 then
		local color = colors[math.random(1,#colors)]
		model.SpeakerMain.SelectionBox.Color = BrickColor.new(color)
		model.SpeakerMain2.SelectionBox.Color = BrickColor.new(color)
		model.TableTop.SelectionBox.Color = BrickColor.new(color)
		model.Light.PointLight.Color = color
	end
	if dj.Value ~= nil and dj.Value.Character == nil then
		dj.Value = nil
	end
	if dj.Value ~= nil and dj.Value:DistanceFromCharacter(model.MusicMarker.Position) > 20  then
		model.DjName.Coiner.TextLabel.Text = ""
		Dialog:ShowMessage(dj.Value,"DJ","You walked too far away from the DJ set. You are not the DJ anymore.","Ok") 
		if current_phones ~= nil then
			current_phones:Destroy()
		end
		dj.Value = nil
	end
end


