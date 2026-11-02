-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-06-24 15:09:18
-- Luau version 6, Types version 3
-- Time taken: 0.001609 seconds

return {
	DisplayName = "The Tempest";
	Description = "its pretty dark here lol";
	Ambience = "rbxassetid://80731676483103";
	Disabled = true;
	AmbienceProperties = {
		Volume = 0.5;
	};
	Created = function(arg1) -- Line 16, Named "Created"
		local var4_upvw = 0
		arg1.Connection = game["Run Service"].Heartbeat:Connect(function(arg1_2) -- Line 18
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: var4_upvw (read and write)
			]]
			if not arg1.Map.Parent then
				arg1.Connection:Disconnect()
			else
				var4_upvw += arg1_2
				if 0.25 <= var4_upvw then
					for _, v in pairs(arg1.Map.ToxicWater:GetChildren()) do
						for _, v_2 in pairs(workspace:GetPartBoundsInBox(v.CFrame, v.Size)) do
							local class_Model = v_2:FindFirstAncestorOfClass("Model")
							local var20 = class_Model
							if var20 then
								var20 = class_Model:FindFirstChild("Humanoid")
							end
							if var20 then
								require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(class_Model, "Poisoned", {
									Level = 1;
									Duration = 8;
								})
							end
						end
					end
				end
			end
		end)
	end;
	Destroyed = function(arg1) -- Line 37, Named "Destroyed"
		if arg1.Connection then
			arg1.Connection:Disconnect()
		end
	end;
}