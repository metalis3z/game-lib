-- Pose de portage : quand un joueur porte un animal au-dessus de sa tête (attribut Carrying > 0, EggZoneServer),
-- ses deux bras se lèvent pour le tenir (le marteau est rangé par HammerServer). Appliqué sur chaque client et pour
-- tous les joueurs, par-dessus les animations de Roblox (on écrit Motor6D.Transform), avec une transition douce.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local rad = math.rad

local BLEND_IN, BLEND_OUT = 0.18, 0.22 -- secondes pour lever / baisser les bras
-- R15 : bras levés presque à la verticale, un peu écartés, coudes légèrement pliés vers l'intérieur (les mains sous l'animal)
local R15 = {
	RightShoulder = CFrame.Angles(rad(168), 0, rad(16)),
	LeftShoulder = CFrame.Angles(rad(168), 0, rad(-16)),
	RightElbow = CFrame.Angles(rad(14), 0, rad(-22)),
	LeftElbow = CFrame.Angles(rad(14), 0, rad(22)),
	RightWrist = CFrame.Angles(rad(-10), 0, 0),
	LeftWrist = CFrame.Angles(rad(-10), 0, 0),
}
-- R6 : une seule articulation par bras
local R6 = {
	["Right Shoulder"] = CFrame.Angles(0, 0, rad(168)),
	["Left Shoulder"] = CFrame.Angles(0, 0, rad(-168)),
}

local weights = {} -- [personnage] = 0..1

-- où trouver chaque articulation (partie du corps, nom du joint). On cherche par nom comme HammerClient : selon les
-- réglages d'avatar, le joint est un Motor6D ou un AnimationConstraint (les deux ont .Transform).
local R15_PATHS = {
	{"RightUpperArm", "RightShoulder"}, {"LeftUpperArm", "LeftShoulder"},
	{"RightLowerArm", "RightElbow"}, {"LeftLowerArm", "LeftElbow"},
	{"RightHand", "RightWrist"}, {"LeftHand", "LeftWrist"},
}
local R6_PATHS = {{"Torso", "Right Shoulder"}, {"Torso", "Left Shoulder"}}

local function jointsOf(character)
	local found = {}
	local r15 = character:FindFirstChild("UpperTorso") ~= nil
	for _, path in (r15 and R15_PATHS or R6_PATHS) do
		local part = character:FindFirstChild(path[1])
		local joint = part and part:FindFirstChild(path[2])
		if joint and (joint:IsA("Motor6D") or joint:IsA("AnimationConstraint")) then
			found[joint] = (r15 and R15 or R6)[path[2]]
		end
	end
	return found
end

RunService.Stepped:Connect(function(_, dt)
	for _, player in Players:GetPlayers() do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid and humanoid.Health > 0 then
			local want = (player:GetAttribute("Carrying") or 0) > 0 and 1 or 0
			local w = weights[character] or 0
			if want > w then w = math.min(1, w + dt / BLEND_IN) elseif want < w then w = math.max(0, w - dt / BLEND_OUT) end
			weights[character] = w
			if w > 0 then
				local eased = w * w * (3 - 2 * w)
				for motor, target in jointsOf(character) do
					motor.Transform = motor.Transform:Lerp(target, eased)
				end
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if player.Character then weights[player.Character] = nil end
end)
