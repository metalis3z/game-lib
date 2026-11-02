-- Adhérence quand on court : au sol, le personnage va exactement où le joueur le dirige et s'arrête net (pas de patinage, même à
-- très grande vitesse). En l'air, le saut garde son élan et glisse (Roblox le freinerait dès qu'on lâche la touche) : on peut
-- quand même l'orienter un peu. À l'atterrissage, il glisse un tout petit peu (LANDING_SLIDE secondes) puis reprend son adhérence.
-- Rien n'est touché sur la bande de course (WalkSpeed 0), assis, en cinématique (PlatformStand) ou quand on est projeté.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local LANDING_SLIDE = 0.22 -- durée de la petite glissade à l'atterrissage
local LANDING_GRIP = 10    -- pendant cette glissade, vitesse à laquelle l'élan rejoint la direction voulue (plus haut = moins de glisse)
local AIR_STEER = 3        -- en l'air, la direction voulue n'oriente l'élan que doucement
local AIR_DRAG = 0.35      -- sans toucher aux touches, l'élan en l'air ne baisse que très peu
local GROUNDED = {
	[Enum.HumanoidStateType.Running] = true,
	[Enum.HumanoidStateType.RunningNoPhysics] = true,
	[Enum.HumanoidStateType.Landed] = true,
}
local AIR = {
	[Enum.HumanoidStateType.Freefall] = true,
	[Enum.HumanoidStateType.Jumping] = true,
}
local landedAt = -math.huge
local airMomentum -- élan horizontal gardé pendant le saut (nil au sol)
local slide -- élan de la petite glissade d'atterrissage

RunService.PreSimulation:Connect(function(dt)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = humanoid and humanoid.RootPart
	if not root or humanoid.Health <= 0 or humanoid.PlatformStand or humanoid.Sit or humanoid.WalkSpeed <= 0
		or player:GetAttribute("OnTreadmill") or root.Anchored then
		airMomentum = nil
		return
	end
	local state = humanoid:GetState()
	local move = humanoid.MoveDirection
	local wanted = Vector3.new(move.X, 0, move.Z) * humanoid.WalkSpeed
	local velocity = root.AssemblyLinearVelocity
	if AIR[state] then
		-- en l'air : on garde l'élan du saut (au départ, celui qu'il avait en courant)
		airMomentum = airMomentum or Vector3.new(velocity.X, 0, velocity.Z)
		if wanted.Magnitude > 0.1 then
			airMomentum = airMomentum:Lerp(wanted, 1 - math.exp(-dt * AIR_STEER))
		else
			airMomentum *= math.exp(-dt * AIR_DRAG)
		end
		root.AssemblyLinearVelocity = Vector3.new(airMomentum.X, velocity.Y, airMomentum.Z)
		return
	end
	if not GROUNDED[state] then airMomentum = nil return end -- projeté, en train de se relever, de nager, de grimper...
	if airMomentum then -- il vient d'atterrir : petite glissade avec l'élan du saut
		landedAt = os.clock()
		slide = airMomentum
		airMomentum = nil
	end
	local horizontal
	if slide and os.clock() - landedAt < LANDING_SLIDE then
		slide = slide:Lerp(wanted, 1 - math.exp(-dt * LANDING_GRIP))
		horizontal = slide
	else
		slide = nil
		horizontal = wanted -- en courant : adhérence totale
	end
	root.AssemblyLinearVelocity = Vector3.new(horizontal.X, velocity.Y, horizontal.Z)
end)
