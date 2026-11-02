local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_StockEventController_0 = l_ReplicatedStorage_0.Controllers.StockEventController;
local v4 = require(l_StockEventController_0.ClientAPI);
local v5 = require(l_StockEventController_0);
local v6 = require(l_StockEventController_0.Interfaces.Single);
local v7 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v8 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v9 = require(l_ReplicatedStorage_0.Packages.Observers);
local v10 = require(l_ReplicatedStorage_0.Packages.Timer);
local v11 = require(l_ReplicatedStorage_0.Packages.Trove);
local v12 = require(l_ReplicatedStorage_0.Packages.Net);
local v13 = v4.create("Taco9");
return {
	Start = function(_)
		v9.observeAttribute(l_ReplicatedStorage_0, "StockEvent", function(v15)
			if not v15 then
				return nil;
			else
				local v16, v17 = v13:ListItems();
				if not v16 or typeof(v17) ~= "table" then
					return nil;
				else
					local v18 = v6:Setup(v13, v17);
					local v22 = v9.observeTag("StockMachinePrompt", function(v19)
						local v20 = v11.new();
						local function v21()
							if not v8:Wait(l_LocalPlayer_0) then
								return;
							else
								v19.Enabled = v5:IsEnabled();
								return;
							end;
						end;
						v20:Add(task.spawn(function()
							if not v8:Wait(l_LocalPlayer_0) then
								return;
							else
								v20:Add(v10.Simple(1, v21));
								task.spawn(v21);
								return;
							end;
						end));
						v20:Add(v19.Triggered:Connect(function()
							if not v8:Get(l_LocalPlayer_0) then
								return;
							else
								v18:Toggle();
								return;
							end;
						end));
						return function()
							v20:Destroy();
						end;
					end);
					local v30 = v9.observeTag("StockMachine", function(v23)
						local v29 = v23.DeliveryHitbox.Touched:Connect(function(v24)
							if v24.Name ~= "HumanoidRootPart" then
								return;
							else
								local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v24.Parent);
								if not l_l_Players_0_PlayerFromCharacter_0 or l_l_Players_0_PlayerFromCharacter_0 ~= l_LocalPlayer_0 then
									return;
								elseif not l_l_Players_0_PlayerFromCharacter_0:GetAttribute("StealingIndex") then
									return;
								elseif not v5:IsEnabled() then
									return;
								else
									local v26, _, _ = v12:RemoteFunction("StockEventService/Delivery"):InvokeServer(v13.MachineName, v23.DeliveryHitbox);
									if not v26 then
										return;
									else
										task.spawn(function()
											v7:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx["Fuse Machine"].Deposit);
										end);
										return;
									end;
								end;
							end;
						end);
						return function()
							v29:Disconnect();
						end;
					end);
					return function()
						v18:Close();
						v18:Destroy();
						v22();
						v30();
					end;
				end;
			end;
		end);
	end
};