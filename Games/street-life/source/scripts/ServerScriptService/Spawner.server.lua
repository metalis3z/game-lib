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

local SpawnSettings = {
	DefaultSpawns = 5,
	Timer = 300
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

local OwnsGamepass = function(Player, Name)
	for _,v in next, Spawner_IDs do
		if string.lower(_) == string.lower(Name) then
			if game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, v) then
				return true
			end
		end
	end
	for _,v in next, Old_Spawner_IDs do
		if string.lower(_) == string.lower(Name) then
			if game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, v) then
				return true
			end
		end
	end
	return false
end

local SpawnTool = function(Player, Name, Spawns, Timer)
	if Spawns.Value > 0 then
		if Player.PlayerGui:FindFirstChild('Spawner') then 
			Player.PlayerGui:FindFirstChild('Spawner'):Destroy() 
		end
		local Tool = game:FindService('ServerStorage'):FindFirstChild(Name):Clone()
		Tool.Parent = Player.Backpack
		local SPAWNER = Instance.new('BoolValue', Tool)
		SPAWNER.Name = 'SPAWNER'
		Spawns.Value -= 1
		local Clone = script:FindFirstChild('Spawner'):Clone()
		Clone.Tool.Text = 'SPAWNED "' .. Name .. '"'
		Clone.Tool.Left.Text = 'SPAWNS LEFT: ' .. Spawns.Value
		Clone.Tool.Timer.Text = 'TIME TILL NEXT SPAWN: ' .. tostring(Timer) .. ' second(s)'
		Clone.Parent = Player.PlayerGui
		task.wait(2)
		if Clone then
			Clone:WaitForChild('Tool')
			Clone.Tool:WaitForChild('Timer')
		end
		for _ = 1, 100 do
			if Clone then
				Clone.Tool.TextTransparency += .01
				Clone.Tool.UIStroke.Transparency += .01
				Clone.Tool.Timer.TextTransparency += .01
				Clone.Tool.Timer.UIStroke.Transparency += .01
			end
		end
		if Clone then 
			Clone:Destroy() 
		end
	else
		if Player.PlayerGui:FindFirstChild('Spawner') then 
			Player.PlayerGui:FindFirstChild('Spawner'):Destroy() 
		end
		local Clone = script:FindFirstChild('Spawner'):Clone()
		Clone.Tool.Text = '0 SPAWNS LEFT'
		Clone.Tool.Left.Text = ''
		Clone.Tool.Timer.Text = 'TIME TILL NEXT SPAWN: ' .. tostring(Timer) .. ' second(s)'
		Clone.Parent = Player.PlayerGui
		task.wait(3)
		Clone:WaitForChild('Tool')
		Clone.Tool:WaitForChild('Timer')
		for _ = 1, 100 do
			if Clone then
				Clone.Tool.TextTransparency += .01
				Clone.Tool.UIStroke.Transparency += .01
				Clone.Tool.Timer.TextTransparency += .01
				Clone.Tool.Timer.UIStroke.Transparency += .01
			end
		end
		if Clone then 
			Clone:Destroy() 
		end
	end
end


game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote').OnServerEvent:Connect(function(Player, Message, Arg)
	if Arg ~= nil and Arg == 'Spawn' then
		local Split = string.split(string.lower(Message), ' ')
		local Spawns = Player:FindFirstChild('Spawns')

		if Split[2] == 'fn5.7' or Split[2] == 'fn' then
			Split[2] = 'fn 5.7'
		end
		
		if Split[2] == 'syndicate' or Split[2] == 'syn' then
			Split[2] = 'syndicate arpdrum'
		end

		if Split[2] == 'auto' then
			Split[2] = 'auto honeybadger'
		end

		if Split[2] == "wsk" then
			Split[2] = "wsk honeybadger"
		end

		if Split[2] == "perun" then
			Split[2] = "perun x-16"
		end

		if Split[1] == '/sg' and Split[2] then
			if Spawners[Player.UserId] then
				for _,v in next, Spawners[Player.UserId] do
					if string.lower(v) == string.lower(Split[2]) then
						SpawnTool(Player, v, Spawns, math.random(200, 300))
						return
					end
				end
			end
			if OwnsGamepass(Player, Split[2]) == true then
				for _,v in next, game:FindService('ServerStorage'):GetChildren() do
					if string.lower(Split[2]) == string.lower(v.Name) then
						SpawnTool(Player, v.Name, Spawns, math.random(200, 300))
						return
					end
				end
			end
		end
	end
end)

game:FindService('Players').PlayerAdded:Connect(function(Player)
	local Spawns = script:FindFirstChildOfClass('NumberValue'):Clone()
	Spawns.Parent = Player
	Spawns.Value = SpawnSettings.DefaultSpawns

	local Timer = SpawnSettings.Timer

	Player.Chatted:Connect(function(Message)
		local Split = string.split(string.lower(Message), ' ')

		if Split[2] == 'fn5.7' or Split[2] == 'fn' then
			Split[2] = 'fn 5.7'
		end
		
		if Split[2] == 'syndicate' or Split[2] == 'syn' then
			Split[2] = 'syndicate arpdrum'
		end

		if Split[2] == 'auto' then
			Split[2] = 'auto honeybadger'
		end

		if Split[2] == "wsk" then
			Split[2] = "wsk honeybadger"
		end

		if Split[2] == "perun" then
			Split[2] = "perun x-16"
		end

		if Split[1] == '/sg' and Split[2] then
			if Spawners[Player.UserId] then
				for _,v in next, Spawners[Player.UserId] do
					if string.lower(v) == string.lower(Split[2]) then
						SpawnTool(Player, v, Spawns, Timer)
						return
					end
				end
			end
			if OwnsGamepass(Player, Split[2]) == true then
				for _,v in next, game:FindService('ServerStorage'):GetChildren() do
					if string.lower(Split[2]) == string.lower(v.Name) then
						SpawnTool(Player, v.Name, Spawns, Timer)
						return
					end
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait(1) do
			if Spawns.Value ~= SpawnSettings.DefaultSpawns then
				if Timer <= 0 then
					Spawns.Value += 1
					Timer = SpawnSettings.Timer
				else
					Timer -= 1
					if Player:FindFirstChild('PlayerGui') then
						if Player.PlayerGui:FindFirstChild('Spawner') then
							Player.PlayerGui:FindFirstChild('Spawner'):WaitForChild('Tool'):FindFirstChild('Timer').Text = 'TIME TILL NEXT SPAWN: ' .. tostring(Timer) .. ' second(s)'
						end
					end
				end
			end
		end
	end)
	
	task.wait(5)

	local GiftedSpawners = Player:WaitForChild('stored'):WaitForChild('Spawners')
	local Split = string.split(GiftedSpawners.Value, ' ')

	for _,v in next, Split do
		if v ~= '' and v ~= ' ' then
			if game:FindService('ServerStorage'):FindFirstChild(v) then
				if not Spawners[Player.UserId] then
					Spawners[Player.UserId] = {v}
				else
					table.insert(Spawners[Player.UserId], v)
				end
			end
		end
	end
end)