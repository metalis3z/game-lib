-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
game:GetService("ServerScriptService")
local v_u_3 = game:GetService("ServerStorage")
local v4 = game:GetService("StarterPlayer")
local v_u_5 = require(v4.StarterPlayerScripts.Controllers.PermissionController)
local v_u_6 = require(v1.Registries.PermissionRegistries.PermissionNodesEnumsType)
local v_u_7 = true
task.delay(5, function()
	-- upvalues: (ref) v_u_7
	v_u_7 = false
end)
local v_u_8 = {
	["DefaultAdmin"] = true,
	["DefaultDebug"] = true,
	["DefaultUtil"] = true
}
return function(p9)
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_8, (copy) v_u_2, (ref) v_u_7, (copy) v_u_3
	p9:RegisterHook("BeforeRun", function(p_u_10)
		-- upvalues: (ref) v_u_5, (ref) v_u_6, (ref) v_u_8, (ref) v_u_2, (ref) v_u_7, (ref) v_u_3
		local v11 = p_u_10.Executor
		local v12 = true
		local v13 = p_u_10.RawText
		local v14 = v11 and v13
		local v15 = v_u_5:HasPermissionNode(v11, v_u_6.RUN_COMMANDS_PERMISSION)
		if v_u_8[p_u_10.Group] and not v_u_5:HasPermissionNode(v11, v_u_6.GLOBAL_COMMANDS_PERMISSION) then
			p_u_10:Reply("You don\'t have permission to run this command. Please verify that your UserId is Authorized.", Color3.fromRGB(255, 170, 34))
			return ""
		end
		if not (v15 or v_u_2:IsStudio()) then
			if not v_u_7 then
				p_u_10:Reply("You don\'t have permission to run this command. Please verify that your UserId is Authorized.", Color3.fromRGB(255, 170, 34))
			end
			return ""
		end
		if not v12 then
			if v14 and not v_u_7 then
				p_u_10:Reply("CMDR is currently globally disabled.", Color3.fromRGB(255, 170, 34))
			end
			return ""
		end
		if p_u_10.Executor and (v13 and v_u_2:IsServer()) then
			task.spawn(function()
				-- upvalues: (ref) v_u_3, (copy) p_u_10
				require(v_u_3.Services.Utilities.LogCommand)(p_u_10)
			end)
		end
	end)
end
