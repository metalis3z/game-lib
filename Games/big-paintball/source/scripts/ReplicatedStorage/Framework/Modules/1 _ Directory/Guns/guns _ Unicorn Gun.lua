-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = {};
local v2 = {
	displayName = "Unicorn Gun", 
	description = "Harness the power of rainbows and sunshine! \240\159\140\136\240\159\140\164\239\184\143", 
	thumbnail = "rbxassetid://6721352988", 
	quality = true, 
	premium = false, 
	offsale = false, 
	disabled = false, 
	isLimited = false, 
	customDisplay = "", 
	price = 777777, 
	gamepassId = 0, 
	productId = 0, 
	damage = 100, 
	velocity = 280, 
	automatic = true, 
	shotrate = 0.1, 
	zoomAmount = 1, 
	additionalSpeed = 2, 
	disableRagdoll = false, 
	offsets = {
		firstPerson = {
			idle = CFrame.new(0.75, -0.75, -2), 
			left = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, 0.08726646259971647), 
			right = CFrame.new(0.75, -0.75, -2) * CFrame.Angles(0, 0, -0.08726646259971647), 
			fire = CFrame.new(0, 0, 0.35) * CFrame.Angles(0.05235987755982989, 0, 0), 
			sprint = CFrame.new(0.75, -1.2, -2) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}, 
		thirdPerson = {
			idle = CFrame.new(0.3, 0.5, -1.35), 
			left = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
			right = CFrame.new(0.3, 0.5, -1.35) * CFrame.Angles(-0.08726646259971647, 0, 0), 
			fire = CFrame.new(0, 0, 0.35) * CFrame.Angles(0.08726646259971647, 0, 0), 
			sprint = CFrame.new(0.3, 0, -1.35) * CFrame.Angles(-0.2617993877991494, 0, 0)
		}
	}
};
local u2 = Random.new();
function v2.killEffect(p1)
	if p1 and p1.PrimaryPart then
		local l__UpperTorso__3 = p1:FindFirstChild("UpperTorso");
		local l__Head__4 = p1:FindFirstChild("Head");
		u1.Audio.Play("rbxassetid://6809940518", p1.UpperTorso, 1, 0.75, 300);
		local v5, v6 = u1.Functions.CreateParticleHost(p1:GetPrimaryPartCFrame());
		for v7, v8 in ipairs(game.ReplicatedStorage.Assets.Particles:FindFirstChild("Unicorn KillFX"):GetChildren()) do
			local v10 = v8:Clone();
			v10.Parent = v6;
			v10:Emit(3);		
		end;
		u1.Functions.AddDebris(v5, 4);
		if u2:NextInteger(1, 2) == 2 then
			coroutine.wrap(function()
				local v11 = u1.Assets:FindFirstChild("UnicornRainbow"):Clone();
				local l__Cloud1__12 = v11.Cloud1;
				local l__Cloud2__13 = v11.Cloud2;
				local v14 = l__Cloud1__12:FindFirstChildOfClass("Beam");
				local l__Sparkles__15 = l__Cloud1__12:FindFirstChild("Sparkles");
				local l__Sparkles__16 = l__Cloud2__13:FindFirstChild("Sparkles");
				l__Cloud1__12.Transparency = 1;
				l__Cloud2__13.Transparency = 1;
				v14.Width0 = 0;
				v14.Width1 = 0;
				local l__Size__17 = l__Cloud1__12.Size;
				l__Cloud1__12.Size = l__Size__17 / 3;
				l__Cloud2__13.Size = l__Size__17 / 3;
				v11:SetPrimaryPartCFrame(l__Head__4.CFrame);
				v11.Parent = u1.Debris;
				u1.Audio.Play("rbxassetid://6814221323", v11.PrimaryPart, 1, 0.3, 250);
				u1.Functions.FastTween({ l__Cloud1__12, l__Cloud2__13 }, {
					Size = l__Size__17, 
					Transparency = 0
				}, { 0.4, "Back", "Out" }).Completed:Wait();
				u1.Functions.FastTween(v14, {
					Width0 = 2, 
					Width1 = 2
				}, { 0.5, "Expo", "Out" });
				u1.Functions.Wait(2.25);
				l__Sparkles__15.Enabled = false;
				l__Sparkles__16.Enabled = false;
				u1.Functions.FastTween(v14, {
					Width0 = 0, 
					Width1 = 0
				}, { 0.4, "Back", "In" });
				local v18 = u1.Functions.FastTween({ l__Cloud1__12, l__Cloud2__13 }, {
					Size = l__Size__17 / 3, 
					Transparency = 1
				}, { 0.6, "Back", "In" });
				u1.Functions.Wait(2);
				v11:Destroy();
			end)();
		end;
	end;
end;
v1["58"] = v2;
return v1;
