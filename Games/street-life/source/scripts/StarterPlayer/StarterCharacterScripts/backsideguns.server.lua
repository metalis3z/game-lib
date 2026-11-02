local character = script.Parent
local Humanoid = character:WaitForChild('Humanoid')
local player = game.Players:GetPlayerFromCharacter(character)	

local ARPDrums = {
	'4M ARPDrum',
	'8B ARPDrum',
	'9B ARPDrum',
	'ABZ ARPDrum',
	'BO ARPDrum ',
	'ARPDrum',
	'DD ARPDrum',
	'EOK ARPDrum',
	'EVIL ARPDrum',
	'FNO ARPDrum',
	'GM ARPDrum',
	'KTA ARPDrum',
	'LAC ARPDrum',
	'OTB ARPDrum',
	'RDO ARPDrum',
	'RR ARPDrum',
	'RVNG ARPDrum',
	'LK ARPDrum',
	'SFM ARPDrum',
	'STB ARPDrum',
	'TB ARPDrum',
	'TD ARPDrum',
	'TNK ARPDrum'
}

if player == nil then return end

function checkBackpack(backpack)
	for i,v in pairs(character:GetChildren()) do
		if v.Name == "GUNBACKPACK" and v:IsA("Accessory") then
			v:Destroy()
		end
	end

	local HasARPDrum = false

	for _,v in next, backpack:GetChildren() do
		if table.find(ARPDrums, v.Name) then
			HasARPDrum = true
		end
	end

	if HasARPDrum == true then
		local bak = game.ServerStorage.BacksideGuns:FindFirstChild("ARDrumBack")
		local clon = bak:Clone()
		clon.Name = "GUNBACKPACK"
		Humanoid:AddAccessory(clon)
	elseif backpack:FindFirstChild('ARPistol') then
		local bak = game.ServerStorage.BacksideGuns:FindFirstChild("ARPistolBack")
		local clon = bak:Clone()
		clon.Name = "GUNBACKPACK"
		Humanoid:AddAccessory(clon)
	end
end

function back()
	local backpack = player.Backpack
	checkBackpack(backpack)
end

player.Backpack.ChildAdded:Connect(back)
player.Backpack.ChildRemoved:Connect(back)