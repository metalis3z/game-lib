--// Services \\--

local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')



--// Movesets \\--

local Movesets = SvSt.Movesets



--// Modules \\--

local SvModules = script.Parent

local WeaponsHandler = require(SvModules.WeaponsHandler)



--// Remotes \\--

local Remotes = RS.Remotes

local MovesetHandlerRemote = Remotes.MovesetHandler



--// Module \\--

local module = {}
module.__index = module



--// Module Functions \\--

function module:AddBaseMoveset(Player: Player, Moveset)
	if not Player.Character then return end
	
	local MovesetFolder: Folder = Movesets:FindFirstChild(Moveset) or Movesets["Honored One"]
	
	if Moveset == 'Kokushibo' then
		WeaponsHandler:AddSword(Player.Character, Moveset)
	elseif Moveset == 'Shadow Monarch' then
		WeaponsHandler:AddDaggers(Player.Character, Moveset)
	elseif Moveset == 'Strongest Of History' then
		WeaponsHandler:AddArms(Player.Character, Moveset)
	end

	for _,Tool: Tool in pairs(Player.Moveset:GetChildren()) do
		if Tool:IsA('Tool') then
			Tool:Destroy()
		end
	end

	for _,v: Tool in pairs(MovesetFolder:GetChildren()) do
		if v:IsA('Tool') then
			local vClone = v:Clone()
			vClone.Parent = Player.Moveset

			if Player.Commands.NoCooldown.Value == true then
				vClone:SetAttribute('CDS', 0)
			end
		end
	end
	
	MovesetHandlerRemote:FireClient(Player)
end

function module:AddAwakeningMoveset(Player: Player, MovesetName)
	local MovesetFolder = game.ServerStorage.Movesets[MovesetName]:FindFirstChild('Awakening')

	if MovesetFolder then
		for _,Tool: Tool in pairs(Player.Moveset:GetChildren()) do
			if Tool:IsA('Tool') then
				Tool:Destroy()
			end
		end

		for _,v: Tool in pairs(MovesetFolder:GetChildren()) do
			if v:IsA('Tool') then
				local vClone = v:Clone()
				vClone.Parent = Player.Moveset

				if Player.Commands.NoCooldown.Value == true then
					vClone:SetAttribute('CDS', 0)
				end
			end
		end
	end

	MovesetHandlerRemote:FireClient(Player)
end

function module:AdddoubleAwakeningMoveset(Player: Player, MovesetName)
	local MovesetFolder = game.ServerStorage.Movesets[MovesetName]:FindFirstChild('Super')

	if MovesetFolder then
		for _,Tool: Tool in pairs(Player.Moveset:GetChildren()) do
			if Tool:IsA('Tool') then
				Tool:Destroy()
			end
		end

		for _,v: Tool in pairs(MovesetFolder:GetChildren()) do
			if v:IsA('Tool') then
				local vClone = v:Clone()
				vClone.Parent = Player.Moveset

				if Player.Commands.NoCooldown.Value == true then
					vClone:SetAttribute('CDS', 0)
				end
			end
		end
	end

	MovesetHandlerRemote:FireClient(Player)
end

function module:UpdateMoveset(Player, NewMoveset: boolean)
	MovesetHandlerRemote:FireClient(Player, NewMoveset)
end

return module
