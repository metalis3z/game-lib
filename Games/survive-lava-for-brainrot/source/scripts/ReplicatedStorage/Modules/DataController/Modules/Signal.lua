-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = Instance.new("BindableEvent")
local v_u_2 = false
v1.Event:Connect(function()
	-- upvalues: (ref) v_u_2
	v_u_2 = true
end)
v1:Fire()
v1:Destroy()
local v3 = v_u_2 == false and true or false
local v4 = require(script.Deferred)
local v5 = require(script.Immediate)
local v6 = v3 and v4 and v4 or v5
v6.Deferred = v4
v6.Immediate = v5
return v6
