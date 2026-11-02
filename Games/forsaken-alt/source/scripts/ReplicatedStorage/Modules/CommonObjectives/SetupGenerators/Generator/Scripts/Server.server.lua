 -- <- Services -> --
local Players = game:GetService('Players');

-- <- Private Variables -> --
local Generator = script:FindFirstAncestorWhichIsA('Model');
local Remotes = Generator:FindFirstChild('Remotes');

local RF = Remotes:FindFirstChild('RF');
local BE = Remotes:FindFirstChild('BE');
local RE = Remotes:FindFirstChild('RE');

-- <- Functions -> --
function GetNearGenerator(Player: Player)
	local GetNearGenerator, GeneratorMag
	local Character = Player.Character
	if not Character then
		return	
	end
	--
	local PlayerPos = Character.PrimaryPart.Position
	--
	for Index, Value in workspace.Map.Ingame:GetDescendants() do 
		if Value.Name == 'Generator' then 
			local Main = Value:FindFirstChild('Main')
			if Main and Main:IsA('BasePart') then
				if GetNearGenerator then 
					local CurrentMag = (Main.Position - PlayerPos).Magnitude
					--
					if CurrentMag < GeneratorMag then 
						GetNearGenerator = Value
						GeneratorMag = (Main.Position - PlayerPos).Magnitude
					end
				else 
					GetNearGenerator = Value
					GeneratorMag = (Main.Position - PlayerPos).Magnitude
				end
			end
		end
	end
	--
	return GetNearGenerator, GeneratorMag
end

function GetPosition(Player: Player, GeneratorFound: Model)
	local Position, PositionMag, InstanceXd
	local Character = Player.Character
	if not Character then
		return	
	end
	--
	local PlayerPos = Character.PrimaryPart.Position
	--
	for Index, Value in GeneratorFound:GetChildren() do 
		if Value:IsA('Folder') and Value.Name == 'Positions' then
			for _, Things in Value:GetChildren() do 
				if Things and Things:IsA('BasePart') then
					if Position then 
						local CurrentMag = (Things.Position - PlayerPos).Magnitude

						if CurrentMag < PositionMag then 
							Position = Things.Name
							InstanceXd = Things
							PositionMag = (Things.Position - PlayerPos).Magnitude
						end
					else 
						Position = Things.Name
						InstanceXd = Things
						PositionMag = (Things.Position - PlayerPos).Magnitude
					end
				end
			end
		end
	end
	--
	return Position, InstanceXd
end

function HandleRF(Player: Player, Action: string)
	local GeneratorFound, Magnitude = GetNearGenerator(Player)
	if not GeneratorFound then
		return
	end
	--
	local Character = Player.Character
	if not Character then
		return	
	end
	--
	if Action == 'enter' then
		local Position, PositionInstance = GetPosition(Player, GeneratorFound)
		--
		if Magnitude >= 10 then
			return 'tooFar'
		end
		--
		if Character.Parent.Name == 'Spectating' then
			return 'isUnknownTeam'
		end
		--
		if Character.Parent.Name == 'Killers' then
			return 'isKiller'
		end
		--
		if GeneratorFound:GetAttribute('Completed') then
			return 'alreadyFixed'
		end
		--
		if PositionInstance:GetAttribute('Used') then
			return 'positionOccupied'
		end
		--
		local NewValue = Instance.new('IntValue')
		NewValue.Name = 'FixingGenerator'
		NewValue.Parent = Player.Character
		--
		Character:PivotTo(PositionInstance.CFrame)
		--
		PositionInstance:SetAttribute('Used', true)
		--
		return 'fixing', Position, GeneratorFound
	elseif Action == 'leave' then 
		local Position, PositionInstance = GetPosition(Player, GeneratorFound)
		PositionInstance:SetAttribute('Used', nil)
		--
		Player:FindFirstChild('FixingGenerator'):Destroy()
		--
		return 'notFixing'
	end
end

function HandleBE(Player: Player, ...)
	warn(...)
end

function HandleRE(Player: Player, ...)
	local GeneratorFound, Magnitude = GetNearGenerator(Player)
	if not GeneratorFound then
		return
	end
	--
	local Progress = GeneratorFound:FindFirstChild('Progress')
	if not Progress then 
		return
	end
	--
	Progress.Value += GeneratorFound:GetAttribute('PowerGain')
	--
	if Progress.Value >= 100 and not GeneratorFound:GetAttribute('Completed') then
		BE:Fire(GeneratorFound, Progress.Value)
		--
		GeneratorFound:FindFirstChild('Progress'):SetAttribute('Completed', true)
		GeneratorFound:SetAttribute('Completed', true)
		return
	end
end

-- <- Connections -> --
RF.OnServerInvoke = function(Player: Player, ...)
	return HandleRF(Player, ...)
end

RE.OnServerEvent:Connect(HandleRE)
BE.Event:Connect(HandleBE)