if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local GiftedSpawners = Player:WaitForChild('stored'):WaitForChild('Spawners')

local SpawnersFrame, CommandsFrame = script.Parent:FindFirstChild('Frame'):FindFirstChild('Spawners'), script.Parent:FindFirstChild('Frame'):FindFirstChild('Commands')

local Spawners = {
	[2393807480] = {'Glock17', '1911', 'FN 5.7', 'Perun X-16', 'Syndicate ARPDrum'},
	[1092113698] = {'Glock17'},
	[2590865835] = {'GlockSwitch'},
	[4379263687] = {'Mac'},
	[2694916879] = {'Mac'},
	[2203816281] = {'Draco'},
	[6070839402] = {'Mac'},
	[1034665242] = {'Mac'},
	[5569120780] = {'Glock17'},
	[5345537379] = {'Mac'},
	[1194310649] = {'Glock17'},
	[2210401003] = {'GlockSwitch'},
	[4319007974] = {'HoneyBadger'},
	[234447508] = {'HoneyBadger'},
	[1577267016] = {'HoneyBadger', 'GlockSwitch'},
	[2015206173] = {'Vector'},
	[675136891] = {'AK-47', 'Perun X-16'},
	[508672823] = {'Auto HoneyBadger'},
	[3672265218] = {'Tec-9'},
	[1071917745] = {'WSK HoneyBadger'},
	[7053080028] = {'AK-47'},
	[301587006] = {'ARPDrum'},
	[672566384] = {'AK-47'},
	[3411576219] = {'AK-47'},
	[2488298262] = {'Syndicate ARPDrum'},
	[3567960000] = {'AK-47'},
	[1283031640] = {'Perun X-16', 'FN 5.7'},
	[5010495238] = {'GlockSwitch', 'ARPDrum'},
	[2284686495] = {'MPX', 'Pizza'},
	[5379037899] = {'MPX', 'AK-47', 'Shotgun', 'HoneyBadger', 'Vector'},
	[3268056248] = {'GlockSwitch', 'MPX'},
	[470853301] = {'Burger', 'GlockSwitch', 'MPX'},
	[2962531758] = {'AK-47'},
	[2492981191] = {'HoneyBadger'},
	[2606680098] = {'Perun X-16'},
	[5325796616] = {'HoneyBadger'},
	[650935916] = {'TommyGun'},
	[6082748194] = {'Perun X-16'},
	[3685471057] = {'Perun X-16'},
	[4552467643] = {'Perun X-16', 'Burger'},
	[1376401709] = {'Perun X-16', 'Burger'},
	[639471724] = {'Draco'},
	[548040771] = {'Draco'},
	[3479554206] = {'Draco'},
	[5308367697] = {'Glock19X'}
}

local Spawner_IDs = {
	['Glock17'] = 800268493,
	['Mac'] = 800394500,
	['Draco'] = 800432505,
	['FN 5.7'] = 800082637,
	['Knife'] = 800249480,
	['HoneyBadger'] = 800280525,
	['GlockSwitch'] = 800419449,
	['Vector'] = 877637612,
	['Glock19X'] = 897502289
}


local Old_Spawner_IDs = {
	['Glock17'] = 716518209,
	['Mac'] = 734671874,
	['Draco'] = 790484054,
	['FN 5.7'] = 788499868,
	['Knife'] = 788267888,
	['HoneyBadger'] = 793793113,
	['GlockSwitch'] = 793485939
}

for _,v in next, Spawner_IDs do
	if tonumber(v) ~= nil then
		if game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, v) then
			local Clone = script:FindFirstChild('Template'):Clone()
			Clone.Text = _
			Clone.Name = Clone.Text
			Clone.Visible = true
			Clone.Parent = SpawnersFrame:FindFirstChild('List')
		end
	end
	task.wait(.1)
end

for _,v in next, Old_Spawner_IDs do
	if tonumber(v) ~= nil then
		if game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, v) then
			local Clone = script:FindFirstChild('Template'):Clone()
			Clone.Text = _
			Clone.Name = Clone.Text
			Clone.Visible = true
			Clone.Parent = SpawnersFrame:FindFirstChild('List')
		end
	end
	task.wait(.1)
end

local Split = string.split(GiftedSpawners.Value, ' ')
for _,v in next, Split do
	if v ~= '' and v ~= ' ' then
		if not Spawners[Player.UserId] then
			Spawners[Player.UserId] = {v}
		else
			table.insert(Spawners[Player.UserId], v)
		end
	end
end

if Spawners[Player.UserId] then
	for _,v in next, Spawners[Player.UserId] do
		local Clone = script:FindFirstChild('Template'):Clone()
		Clone.Text = v
		Clone.Name = Clone.Text
		Clone.Visible = true
		Clone.Parent = SpawnersFrame:FindFirstChild('List')
	end
end

for _,v in next, SpawnersFrame:FindFirstChild('List'):GetChildren() do
	if v:IsA('TextButton') then
		v.MouseButton1Click:Connect(function()
			game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('/sg ' .. v.Text, 'Spawn')
		end)
	end
end

for _,v in next, CommandsFrame:FindFirstChild('List'):GetChildren() do
	if v:IsA('TextButton') then
		v.MouseButton1Click:Connect(function()
			game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer(v.Text)
		end)
	end
end

game:FindService('UserInputService').InputBegan:Connect(function(Key, Processed)
	if Key and not Processed then
		if Key.KeyCode == Enum.KeyCode.DPadDown or Key.KeyCode == Enum.KeyCode.V then
			script.Parent.Enabled = not script.Parent.Enabled
		end
	end
end)

Player.Chatted:Connect(function(Message)
	if string.lower(Message) == '/ui' or string.lower(Message) == '/gui' then
		script.Parent.Enabled = not script.Parent.Enabled
	end
end)

script.Parent:FindFirstChild('Frame'):FindFirstChild('Pay'):FindFirstChild('TextBox').FocusLost:Connect(function()
	if tonumber(script.Parent:FindFirstChild('Frame'):FindFirstChild('Pay'):FindFirstChild('TextBox').Text) ~= nil then
		game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer(script.Parent:FindFirstChild('Frame'):FindFirstChild('Pay'):FindFirstChild('TextBox').Text, 'Pay')
	end
	script.Parent:FindFirstChild('Frame'):FindFirstChild('Pay'):FindFirstChild('TextBox').Text = '0'
end)

script.Parent.Close.MouseButton1Click:Connect(function()
	script.Parent.Enabled = false
end)

task.wait(3)
Spawners = nil
Spawner_IDs = nil
Old_Spawner_IDs = nil