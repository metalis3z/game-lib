-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl


local v1 = script:WaitForChild("LoadingGui")
local v2 = v1:WaitForChild("LoadingScreen"):WaitForChild("Main")
local v_u_3 = v2:WaitForChild("Percent")
local v4 = v2:WaitForChild("Information")
local v5 = v2:WaitForChild("Warning")
local v6 = v2:WaitForChild("Background")
local v7 = v2:WaitForChild("Gradient")
local v_u_8 = v2:WaitForChild("Skip")
Random.new()
local v9 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
v1.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")                                   
local v10 = tick()
local v11 = game.Players.LocalPlayer:WaitForChild("PlayerData")
repeat
	task.wait()
until tick() >= v10 + 5 or v11:GetAttribute("Instances") and #v11:GetDescendants() + 2 >= v11:GetAttribute("Instances")
task.wait(1)
local v12 = {
	"rbxassetid://134140133592064",
	"rbxassetid://130847227676574",
	"rbxassetid://134753108065583",
	"rbxassetid://92467306534030",
	"rbxassetid://133271187378470",
	"rbxassetid://126888822678209",
	"rbxassetid://134433456647407",
	"rbxassetid://79402836249146",
	"rbxassetid://101131998687154",
	"rbxassetid://119078166877350",
	"rbxassetid://136045991032765",
	"rbxassetid://120349631655353",
	"rbxassetid://134561823121130",
	"rbxassetid://140392995135158",
	"rbxassetid://127433151099851",
	"rbxassetid://85754631709537",
	"rbxassetid://106779897025039",
	"rbxassetid://79606286297398",
	"rbxassetid://79937806951825",
	"rbxassetid://118960357307324"
}
v6.Image = v12[math.random(#v12)]
v6.ImageTransparency = 1
game.TweenService:Create(v6, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
	["ImageTransparency"] = 0
}):Play()
v4.TextTransparency = 1
v4.Text = "Grabbing all assets to preload..."
game.TweenService:Create(v4, v9, {
	["TextTransparency"] = 0
}):Play()
local v13 = workspace:GetDescendants()
local v_u_14 = {}
local v_u_15 = 0
for _, v16 in pairs(v13) do
	table.insert(v_u_14, v16)
end
for _, v17 in game.ReplicatedStorage.Assets:GetChildren() do
	if v17.Name ~= "Skins" and v17:IsA("Folder") then
		local v18 = v17:GetDescendants()
		for _, v19 in pairs(v18) do
			table.insert(v_u_14, v19)
		end
	end
end
local v20 = game.StarterPlayer:GetDescendants()
for _, v21 in pairs(v20) do
	table.insert(v_u_14, v21)
end
local v22 = game.StarterGui:GetDescendants()
for _, v23 in pairs(v22) do
	table.insert(v_u_14, v23)
end
task.delay(10, function()
	-- upvalues: (copy) v_u_8
	repeat
		task.wait()
	until game.Players.LocalPlayer:FindFirstChild("PlayerData")
	if not shared.Loaded then
		v_u_8.Visible = true
		game.TweenService:Create(v_u_8, TweenInfo.new(1), {
			["TextTransparency"] = 0
		}):Play()
		v_u_8.MouseButton1Click:Once(function()
			shared.Loaded = true
		end)
	end
end)
v4.TextTransparency = 1
v4.Text = "Beginning to download all assets..."
game.TweenService:Create(v4, v9, {
	["TextTransparency"] = 0
}):Play()
local v24 = #v_u_14
for v25, v_u_26 in pairs(v_u_14) do
	task.delay(v25 / (v24 / 0.75), function()
		-- upvalues: (copy) v_u_26, (ref) v_u_15, (copy) v_u_14, (copy) v_u_3
		if not shared.Loaded then
			local v27 = { v_u_26 }
			game.ContentProvider:PreloadAsync(v27)
			v_u_15 = v_u_15 + 1
			if not shared.Loaded then
				local v28 = v_u_15 / #v_u_14 * 100
				v_u_3.Text = ("%*%%"):format((math.floor(v28)))
			end
		end
	end)
end
repeat
	task.wait()
until #v_u_14 - 100 <= v_u_15 or shared.Loaded

v4.TextTransparency = 1
v4.Text = "Initializing systems..."
game.TweenService:Create(v4, v9, {
	["TextTransparency"] = 0
}):Play()
local v29 = require(game.ReplicatedStorage.Initializer)
v29:Initialize()
repeat
	task.wait()
until v29.Loaded or shared.Loaded
shared.Loaded = true
v_u_3.Text = "100%"
game.TweenService:Create(v4, TweenInfo.new(0.666), {
	["TextTransparency"] = 1,
	["Position"] = UDim2.fromScale(1.55, 1)
}):Play()
game.TweenService:Create(v5, TweenInfo.new(0.666), {
	["TextTransparency"] = 1
}):Play()
game.TweenService:Create(v_u_3.UIStroke, TweenInfo.new(0.666), {
	["Transparency"] = 1
}):Play()
game.TweenService:Create(v_u_3.UIStroke, TweenInfo.new(2), {
	["Thickness"] = 20
}):Play()
game.TweenService:Create(v_u_8, TweenInfo.new(0.666), {
	["TextTransparency"] = 1
}):Play()
task.wait(1)
game.TweenService:Create(v_u_3, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
	["TextTransparency"] = 1
}):Play()
game.TweenService:Create(v7, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	["Position"] = UDim2.fromScale(1, 1.15)
}):Play()
task.wait(0.5)
game.TweenService:Create(v6, TweenInfo.new(0.666), {
	["ImageTransparency"] = 1
}):Play()
game.TweenService:Create(v2, TweenInfo.new(0.75), {
	["BackgroundTransparency"] = 1
}):Play()
game.Debris:AddItem(v1, 0.75)
