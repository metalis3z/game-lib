-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require
local ReplicatedStorage = game:GetService("ReplicatedStorage")

v1(script:WaitForChild("Signal"))

local HitboxClassRemote = ReplicatedStorage:WaitForChild("HitboxClassRemote")
local v2 = v1(script["HitboxClass Module"].Value)
local t = {}

HitboxClassRemote.OnClientEvent:Connect(function(p1, p2) --[[ Line: 11 | Upvalues: t (copy), v2 (copy), HitboxClassRemote (copy) ]]
	if p1 == "Clr" then
		for k, v in pairs(t) do
			v:Destroy()
			t[k] = nil
		end
	else
		if p1 ~= "New" and not t[p2._Tick] then
			warn("No hitbox found on the client for tick value sent. Don\'t change the tick value manually, change the ID instead. (HitboxClass)")

			return
		end

		if p1 == "New" then
			t[p2._Tick] = v2.new(p2)
			HitboxClassRemote:FireServer(p2._Tick)
		end

		if p1 == "Start" then
			t[p2._Tick]:Start()
		end

		if p1 == "Stop" then
			t[p2._Tick]:Stop()
		end

		if p1 == "ClrTag" then
			t[p2._Tick]:ClearTaggedChars()
		end

		if p1 == "Weld" then
			t[p2._Tick]:WeldTo(p2.WeldTo, p2.Offset)
		end

		if p1 == "WeldOfs" then
			t[p2._Tick]:ChangeWeldOffset(p2.Offset)
		end

		if p1 == "Unweld" then
			t[p2._Tick]:Unweld()
		end

		if p1 == "PosCh" then
			t[p2._Tick]:SetPosition(p2.Position)
		end

		if p1 == "Dbg" then
			t[p2._Tick]:SetDebug(p2.Debug)
		end

		if p1 ~= "Des" then
			return
		end

		t[p2._Tick]:Destroy()
		t[p2._Tick] = nil
	end
end)