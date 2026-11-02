-- Vendeur de la boutique de dragons : il salue de la main et dit "Hello!" quand un joueur approche,
-- sa tête suit le joueur, et le petit dragon sur son épaule respire, regarde autour de lui, bat des ailes et remue la queue.
-- Articulations : Weld avec l'attribut Npc (Wave, Head, Dragon) ; celles du dragon gardent leur attribut Anim d'origine.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local GREET_DISTANCE = 34
local A = CFrame.Angles
local sin, rad, clamp, min = math.sin, math.rad, math.clamp, math.min
local player = Players.LocalPlayer

local rig -- {Model, Root, Wave, Head, Dragon, Hello, D = {articulations du dragon}}
local function find()
	local shop = workspace:FindFirstChild("dragon shop")
	local model = shop and shop:FindFirstChild("npc dragon shop")
	local root = model and model.PrimaryPart
	if not root then return nil end
	local r = {Model = model, Root = root, D = {}, Hello = root:FindFirstChild("Hello"), Greet = 0, HeadYaw = 0}
	for _, d in model:GetDescendants() do
		if d:IsA("Weld") then
			local name = d:GetAttribute("Npc")
			if name then
				r[name] = {Weld = d, Base = d.C0}
			elseif d:GetAttribute("Anim") then
				table.insert(r.D, {Weld = d, Base = d.C0, Anim = d:GetAttribute("Anim"), Side = d:GetAttribute("Side") or 1, Phase = d:GetAttribute("Phase") or 0})
			end
		end
	end
	if not (r.Wave and r.Head and r.Dragon) then return nil end -- pas encore entièrement chargé
	return r
end

task.spawn(function()
	while true do
		if not rig or not rig.Model:IsDescendantOf(workspace) then rig = find() end
		task.wait(1)
	end
end)

RunService.RenderStepped:Connect(function(dt)
	local r = rig
	if not r or not r.Root.Parent then return end
	dt = min(dt, 0.1)
	local t = os.clock()
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	local toPlayer = hrp and r.Root.CFrame:PointToObjectSpace(hrp.Position)
	local near = toPlayer ~= nil and toPlayer.Magnitude < GREET_DISTANCE
	r.Greet += ((near and 1 or 0) - r.Greet) * min(1, dt * 5)
	local g = r.Greet
	if r.Hello then r.Hello.Enabled = g > 0.5 and (t % 6) < 3.2 end

	-- bras : levé quand un joueur est là, la main qui s'agite ; sinon il pend et se balance à peine
	local waving = g * ((t % 6) < 3.2 and 1 or 0.35)
	r.Wave.Weld.C0 = r.Wave.Base * A(0, 0, rad(4) * sin(t * 1.3) * (1 - g) + (rad(150) + rad(22) * sin(t * 9)) * waving)

	-- tête : suit le joueur, hoche un peu
	local wantYaw = near and clamp(math.atan2(toPlayer.X, toPlayer.Z), -0.9, 0.9) or sin(t * 0.5) * 0.35
	r.HeadYaw += (wantYaw - r.HeadYaw) * min(1, dt * 4)
	r.Head.Weld.C0 = r.Head.Base * A(rad(3) * sin(t * 1.6) + rad(5) * g * sin(t * 4.5), r.HeadYaw, rad(4) * g * sin(t * 4.5))

	-- dragon : il respire sur l'épaule, et sautille quand son maître salue
	r.Dragon.Weld.C0 = r.Dragon.Base * CFrame.new(0, 0.04 * sin(t * 2) + 0.08 * waving * math.abs(sin(t * 6)), 0) * A(rad(3) * sin(t * 1.1), rad(10) * sin(t * 0.6), 0)
	for _, j in r.D do
		local cf
		if j.Anim == "Neck" then
			cf = A(rad(6) * sin(t * 1.3), r.HeadYaw * 0.5 + rad(12) * sin(t * 0.8), 0)
		elseif j.Anim == "Head" then
			cf = A(rad(8) * sin(t * 1.7 + 1), r.HeadYaw * 0.4, rad(8) * sin(t * 0.9))
		elseif j.Anim == "Jaw" then
			cf = A(rad(14) * math.max(0, sin(t * 0.9)) ^ 4 + rad(16) * waving * math.abs(sin(t * 5)), 0, 0)
		elseif j.Anim == "Wing" then
			cf = A(0, 0, j.Side * (rad(-28) + rad(9) * sin(t * 2.2) + rad(34) * waving * (0.5 + 0.5 * sin(t * 11))))
		elseif j.Anim == "WingTip" then
			cf = A(0, 0, j.Side * (rad(-22) + rad(10) * sin(t * 2.2 - 1) + rad(20) * waving * sin(t * 11 - 1)))
		elseif j.Anim == "Tail" then
			cf = A(rad(5) * sin(t * 1.6 - j.Phase), rad(14) * sin(t * 2 - j.Phase), 0)
		end
		if cf then j.Weld.C0 = j.Base * cf end
	end
end)
