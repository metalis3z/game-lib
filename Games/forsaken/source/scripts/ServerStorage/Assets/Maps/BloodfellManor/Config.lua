-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-11-29 19:55:02
-- Luau version 6, Types version 3
-- Time taken: 0.003170 seconds

return {
	DisplayName = "Bloodfell Manor";
	Description = "from above his lair, the people below despair";
	Render = "rbxassetid://123101580653698";
	Ambience = "rbxassetid://83019897092792";
	AmbienceProperties = {
		Volume = 1;
	};
	Created = function(arg1) -- Line 16, Named "Created"
		task.spawn(function() -- Line 17
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			local Conveyors = arg1.Map.MapBoundaries.Conveyors
			while task.wait(0.1) and Conveyors.Parent do
				for _, v in pairs(Conveyors:GetChildren()) do
					v.AssemblyLinearVelocity = v.CFrame.LookVector * 30
				end
			end
		end)
	end;
}