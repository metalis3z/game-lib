-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-03-18 09:12:43
-- Luau version 6, Types version 3
-- Time taken: 0.001619 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Net_upvr = require(ReplicatedStorage.Packages.Net)
local VFX_upvr = require(ReplicatedStorage.Shared.VFX)
function module.Start() -- Line 6
	--[[ Upvalues[2]:
		[1]: Net_upvr (readonly)
		[2]: VFX_upvr (readonly)
	]]
	Net_upvr:RemoteEvent("GameService/SpawnEffect").OnClientEvent:Connect(function(arg1, arg2, arg3, arg4) -- Line 7
		--[[ Upvalues[1]:
			[1]: VFX_upvr (copied, readonly)
		]]
		local clone_2 = script[arg1]:Clone()
		if arg4 and arg1 ~= "Valentines" then
			local clone = workspace.Road.Start:Clone()
			clone.Parent = clone_2
			clone_2.PrimaryPart = clone
			clone_2:PivotTo(arg4)
			clone_2.PrimaryPart = nil
			clone:Destroy()
		end
		clone_2.Parent = workspace
		VFX_upvr.emit(clone_2)
		for _, v in clone_2:GetDescendants() do
			if v:IsA("Sound") then
				v:Play()
			end
		end
		task.wait(arg3 + 5)
		clone_2:Destroy()
	end)
end
return module