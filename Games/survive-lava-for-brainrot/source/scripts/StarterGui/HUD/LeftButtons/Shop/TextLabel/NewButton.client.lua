-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Registries.UpdateConfig).UpdateTime
if v2 > workspace:GetServerTimeNow() then
	repeat
		task.wait()
	until v2 <= workspace:GetServerTimeNow()
	script.Parent.Visible = true
	script.Parent.Parent.MouseButton1Down:Connect(function()
		script.Parent.Visible = false
	end)
end
