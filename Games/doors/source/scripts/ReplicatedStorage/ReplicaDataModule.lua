local v1 = {
	data = {}, 
	event = {}, 
	players = {}
};
local v2 = { "Knobs", "Revives", "Boosts", "Settings", "Statistics", "Achievements", "FlexAchievement", "RiftItem" };
for v3, v4 in pairs(v2) do
	local v5 = Instance.new("BindableEvent");
	v5.Name = v4 .. "Updated";
	v5.Parent = script;
	v1.event[v4] = v5;
end;

local v6 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaController"));
local l__LocalPlayer__7 = game:GetService("Players").LocalPlayer;
v6.RequestData();
v6.ReplicaOfClassCreated("PlayerProfile", function(p1)
	local v8 = p1.Tags.Player == l__LocalPlayer__7;
	if not v8 then
		local v9 = p1.Tags.Player.Name .. "'s";
	end;
	local l__Data__10 = p1.Data;
	if v8 then
		v1.data = l__Data__10;
		for v11, v12 in pairs(v2) do
			p1:ListenToChange({ v12 }, function(p2)
				v1.event[v12]:Fire(l__Data__10[v12]);
				v1.data = p1.Data;
			end);
			v1.event[v12]:Fire(l__Data__10[v12]);
		end;
	end;
	v1.players[p1.Tags.Player] = {};
	v1.players[p1.Tags.Player].data = l__Data__10;
	v1.players[p1.Tags.Player].event = {};
	for v13, v14 in pairs(v2) do
		p1:ListenToChange({ v14 }, function(p3)
			v1.players[p1.Tags.Player].data = p1.Data;
			--v1.players[p1.Tags.Player].event[v14]:Fire(l__Data__10[v14]);
			--v1.players[p1.Tags.Player].event[script:FindFirstChild(tostring(v14).."Updated")]:Fire(l__Data__10[v14]);
			script:FindFirstChild(tostring(v14).."Updated"):Fire(l__Data__10[v14]);
		end);
		--[[local v15 = Instance.new("BindableEvent");
		v15.Name = v14 .. "Updated";
		v15.Parent = script;
		v1.players[p1.Tags.Player].event[v14] = v15;]] -- tag off this section of code to avoid it making dupes
	end;
end);
local v16 = tick();
while true do
	wait();
	if v6.InitialDataReceived then
		break;
	end;
end;
local v17 = tick();
return v1;
