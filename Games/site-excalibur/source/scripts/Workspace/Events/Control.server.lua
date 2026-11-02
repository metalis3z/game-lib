local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Bullet, IgnoreList = {}, {}
local TweenService = game:GetService("TweenService")

Bullet.Sounds = {
	Richochet = {
		1476374050
	},
	Metal = {
		2303101209,
	},
	Nearmiss = {
		2682548698
	},
	Glass = {
		142082167
	},
	Flesh = {144884872}
}

function DoDamage(Humanoid, Damage)
	Humanoid:TakeDamage(Damage)
end

script.Parent.GunSound.OnServerEvent:connect(function(Player, Sound)
	Sound:Play()
end)

script.Parent.GunReload.OnServerEvent:connect(function(Player, Tool, ReloadTime)
	Tool.Mag.Transparency = 1
	wait(ReloadTime/4)
	Tool.Mag.Transparency = 0
end)

script.Parent.GunShoot.OnServerEvent:connect(function(Player, Tool, Hit, Pos, Distance, Bullets, Target, Damage, HeadshotMultiplier)
	--[[for _, Object in pairs(workspace.Mechanics.Doors:GetChildren()) do
		table.insert(IgnoreList, Object.Mechanics.Interact)
	end]]
	if Target ~= nil and Target ~= "HumanoidRootPart" then
		if Target.Parent ~= nil and Target.Parent:FindFirstChild("Humanoid") then
			Target.Parent:FindFirstChild("Humanoid").Health = Target.Parent:FindFirstChild("Humanoid").Health - Damage
			local s = script.HitS:Clone()
			s.Parent = Player.PlayerGui
			s.TimePosition = 0
			s:Play()
			game.Debris:AddItem(s, s.TimeLength)
			Player.PlayerGui.Client.Cursor.HitM.Visible = true
		elseif Target.Parent.Parent ~= nil and Target.Parent.Parent:FindFirstChild("Humanoid")  then
			Target.Parent.Parent:FindFirstChild("Humanoid").Health = Target.Parent.Parent:FindFirstChild("Humanoid").Health - Damage
			--Player.PlayerGui.Client.Cursor.Sound:Play()
			Player.PlayerGui.Client.Cursor.HitM.Visible = true
		elseif Target.Parent.Parent.Parent ~= nil  and Target.Parent.Parent.Parent:FindFirstChild("Humanoid") then
			Target.Parent.Parent.Parent:FindFirstChild("Humanoid").Health = Target.Parent.Parent.Parent:FindFirstChild("Humanoid").Health - Damage
			--Player.PlayerGui.Client.Cursor.Sound:Play()
			Player.PlayerGui.Client.Cursor.HitM.Visible = true
		end
	end
	Tool.Emitter.Flash:Emit(8)
	Tool.Emitter.Light.Enabled = true
--	Tool.Handle.Shell2:Emit(1)
	local s = Tool.Emitter.GunShot:Clone()
	s.Parent = Tool.Emitter
	s.TimePosition = 0
	s:Play()
	game.Debris:AddItem(s, s.TimeLength)
	wait()
	if Player.PlayerGui.Client.Cursor.HitM.Visible == true then
		Player.PlayerGui.Client.Cursor.HitM.Visible = false
	end
	Tool.Emitter.Light.Enabled = false
	wait(.3)
--	local s1 = Tool.Handle.Shell:Clone()
	--s1.Parent = Tool.Handle
	--s1.TimePosition = 0
	--s1:Play()
	game.Debris:AddItem(s, s.TimeLength)
end)