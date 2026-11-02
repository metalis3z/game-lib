-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
	Data = {
		Duration = 6, 
		MaxLevel = 1, 
		Stackable = false, 
		TimeStackable = false, 
		Hidden = true
	}
};
local v1 = require(game.ReplicatedStorage.Modules.Actors);
local v2 = require(game.ReplicatedStorage.Modules.Util);
v0.Applied = function(v3) --[[ Line: 15 ]] --[[ Name: Applied ]]
	-- upvalues: v1 (copy), v2 (copy)
	if game["Run Service"]:IsClient() then
		local v4 = v1.CurrentActors[v3.Player];
		local v5 = v4 and v4.Animations.Stunned;
		if v5 then
			if typeof(v5) == "table" then
				if v5.Start then
					v5.Start:Play(0);
				end;
				if v5.Loop then
					v5.Loop:Play(0);
				end;
				v3.StunnedAnims = v5;
			else
				v5:Play(0);
			end;
		end;
		if not v3.SpeedMultiplier then
			v3.SpeedMultiplier = v2:CreateSpeedMultiplier(v3.Player, 0, "Stunned");
			return;
		end;
	elseif game["Run Service"]:IsServer() then
		v3.Character:SetAttribute("StunnedDisabled", true);
		v3.Character:SetAttribute("Stunned", true);
		local v6 = v1.CurrentActors[v3.Player];
		if v6 then
			v6:DisableAbilities("Stunned", true);
			local v7 = require(game.ReplicatedStorage.Modules.Sounds);
			v7:PlayVoiceline(v6, "Stunned");
			v7:Play(v6.Config.Sounds.Stunned, {
				Parent = v6.Rig.PrimaryPart
			});
			if v6.Config.StunDuration then
				if v3.UnstunThread then
					task.cancel(v3.UnstunThread);
				end;
				v3.UnstunThread = task.delay(v6.Config.StunDuration, function() --[[ Line: 56 ]]
					-- upvalues: v3 (copy), v6 (copy)
					local v8 = require(game.ReplicatedStorage.Modules.Statuses);
					v8:RemoveStatus(v3.Player, "Stunned");
					if not v8:PlayerHasStatus(v3.Player, "Speed") then
						v8:ApplyStatus(v3.Player, "Speed", {
							Level = 1, 
							Duration = 2.5
						});
					end;
					require(game.ReplicatedStorage.Modules.Sounds):Play(v6.Config.Sounds.StunEnded, {
						Parent = v6.Rig.PrimaryPart
					});
				end);
			end;
		end;
	end;
end;
v0.Removed = function(v9) --[[ Line: 72 ]] --[[ Name: Removed ]]
	-- upvalues: v1 (copy)
	if v9.SpeedMultiplier then
		local l_SpeedMultiplier_0 = v9.SpeedMultiplier;
		v9.SpeedMultiplier = nil;
		task.delay(v9.StunnedAnims and v9.StunnedAnims.End.Length - 0.25 or 0.25, function() --[[ Line: 76 ]]
			-- upvalues: l_SpeedMultiplier_0 (copy)
			game.TweenService:Create(l_SpeedMultiplier_0, TweenInfo.new(0.75), {
				Value = 1
			}):Play();
			game.Debris:AddItem(l_SpeedMultiplier_0, 0.75);
		end);
	end;
	if v9.StunnedAnims then
		if v9.StunnedAnims.Start then
			v9.StunnedAnims.Start:Stop();
		end;
		if v9.StunnedAnims.Loop then
			v9.StunnedAnims.Loop:Stop();
		end;
		if v9.StunnedAnims.End then
			v9.StunnedAnims.End:Play();
		end;
		v9.StunnedAnims = nil;
	end;
	if game["Run Service"]:IsServer() then
		v9.Character:SetAttribute("Stunned", nil);
		local v11 = game.ReplicatedStorage.Assets.UI.StunProtectionVFX.StunProtection:Clone();
		v11.Parent = v9.Character.PrimaryPart;
		task.delay(3 + v1:GetAmountOfLivingActorsOfClass("Sentinel"), function() --[[ Line: 101 ]]
			-- upvalues: v9 (copy), v11 (copy)
			v9.Character:SetAttribute("StunnedDisabled", nil);
			v11.Spawn.Enabled = false;
			game.Debris:AddItem(v11, v11.Spawn.Lifetime.Max);
		end);
		local v12 = v1.CurrentActors[v9.Player];
		if v12 then
			v12:DisableAbilities("Stunned", false);
		end;
	end;
end;
v0.Heartbeat = function(_, _) --[[ Line: 115 ]] --[[ Name: Heartbeat ]]

end;
return v0;