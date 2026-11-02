--credit to quartz games studio
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local t = {
	"Your garden literally grows while you are <b>offline</b>!",
	"The <i>best</i> seeds have a <i>small</i> chance of restocking!",
	"<font color=\"#FFFF00\">Private Servers</font> are free for everyone!",
	"Playing with friends makes the game even more fun!",
	"<font color=\"#FFFF00\">Gold</font> mutations are worth <b>15x</b> more!",
	"There is a small chance for <font color=\"#FF0000\">r</font><font color=\"#FF7F00\">a</font><font color=\"#FFFF00\">i</font><font color=\"#00FF00\">n</font><font color=\"#0000FF\">b</font><font color=\"#4B0082\">o</font><font color=\"#8B00FF\">w</font> mutations worth <b>40x</b> more!",
	"<b>Bigger</b> fruits sell for <b>more</b> money!",
	"Watering cans make plants grow faster, and maybe make seed packs luckier!",
	"Sprinklers <i>passively</i> water nearby plants for you!",
	"You can <b>steal</b> ripe fruits from other players\' gardens!",
	"Watch out for <font color=\"#FF4444\">gnomes</font> and <font color=\"#FF4444\">traps</font> when stealing!",
	"Some plants give <b>multiple harvests</b> per growth cycle!",
	"Mushrooms grant temporary buffs like <b>speed</b> and <b>invisibility</b>!",
	"You can <b>gift</b> harvested fruits to your friends!",
	"Send your favorite content creators gifts through the mail!",
	"Expand your garden up to <b>5 times</b> for maximum growing space!",
	"Fruits need to be ripe for maximum <b>value</b>!",
	"Visit other players\' gardens to see what they are growing!",
	"There is a very small, and we mean <i>small</i> chance a fruit can grow <b>x100000</b> as big",
	"The rarest seeds cost <i>millions</i> but yield legendary harvests!"
}
local t2 = {
	TextLabel = "TextTransparency",
	ImageLabel = "ImageTransparency",
	UIStroke = "Transparency"
}
local v1 = nil
local v2 = nil
local v3 = nil
local t3 = {}
local t4 = {}
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = false
local v8 = nil
local v9 = false
local v10 = nil
local v11 = false
local v12 = nil
local v13 = false
local t5 = {}
local v14 = nil
local v15 = false
local v16 = 0
local v17 = 0
local v18 = 0

local function shuffleClone(p1) --[[ shuffleClone | Line: 72 ]]
	local v1 = table.clone(p1)

	for i = #v1, 2, -1 do
		local v2 = math.random(1, i)
		local v4 = v1[i]

		v1[i] = v1[v2]
		v1[v2] = v4
	end

	return v1
end

local function fadeUpdateText(p1, p2, p3) --[[ fadeUpdateText | Line: 81 | Upvalues: TweenService (copy), v13 (ref) ]]
	task.spawn(function() --[[ Line: 82 | Upvalues: p3 (copy), TweenService (ref), p1 (copy), v13 (ref), p2 (copy) ]]
		local v12 = TweenInfo.new(p3 / 2, Enum.EasingStyle.Linear)
		local v22 = TweenService:Create(p1, v12, {
			TextTransparency = 1
		})

		v22:Play()
		v22.Completed:Wait()

		if v13 then
			return
		end

		p1.Text = p2
		TweenService:Create(p1, v12, {
			TextTransparency = 0
		}):Play()
	end)
end

local function popRandomTip() --[[ popRandomTip | Line: 95 | Upvalues: t5 (ref), shuffleClone (copy), t (copy) ]]
	if #t5 ~= 0 then
		return table.remove(t5, #t5)
	end

	t5 = shuffleClone(t)

	return table.remove(t5, #t5)
end

local function isMobile() --[[ isMobile | Line: 102 | Upvalues: UserInputService (copy) ]]
	return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

local function collectPreloadAssets() --[[ collectPreloadAssets | Line: 106 | Upvalues: PlayerGui (copy), ReplicatedStorage (copy) ]]
	local t = {}

	for k, v in pairs(PlayerGui:GetChildren()) do
		if v:IsA("ScreenGui") then
			for k2, v2 in pairs(v:GetDescendants()) do
				if (v2:IsA("ImageLabel") or v2:IsA("ImageButton")) and (v2.Image and v2.Image ~= "") then
					table.insert(t, v2)
				end
			end
		end
	end

	local Assets = ReplicatedStorage:FindFirstChild("Assets")

	if Assets then
		for k, v in pairs(Assets:GetDescendants()) do
			if v:IsA("ImageLabel") or (v:IsA("ImageButton") or (v:IsA("Decal") or v:IsA("Texture"))) then
				table.insert(t, v)

				continue
			end

			if v:IsA("MeshPart") or v:IsA("Sound") then
				table.insert(t, v)
			end
		end
	end

	local SharedModules = ReplicatedStorage:FindFirstChild("SharedModules")

	if SharedModules then
		local tbl = { "GearImages", "PropImages" }
		local SeedData = SharedModules:FindFirstChild("SeedData")

		if SeedData then
			for k, v in pairs({ "SeedImages", "FruitImages", "PlantImages" }) do
				local v1 = SeedData:FindFirstChild(v)

				if v1 then
					table.insert(tbl, v1)
				end
			end
		end

		for k, v in pairs(tbl) do
			local v2 = if typeof(v) == "string" then SharedModules:FindFirstChild(v) else v

			if v2 then
				for k2, v3 in pairs(v2:GetChildren()) do
					if v3:IsA("StringValue") and v3.Value ~= "" then
						table.insert(t, v3.Value)
					end
				end
			end
		end
	end

	return t
end

local function preloadAssetsAsync() --[[ preloadAssetsAsync | Line: 161 | Upvalues: collectPreloadAssets (copy), v17 (ref), v15 (ref), v16 (ref), ContentProvider (copy), v18 (ref) ]]
	local v1 = collectPreloadAssets()

	v17 = #v1
	v15 = true

	if v17 == 0 then
		v16 = 1
	else
		ContentProvider:PreloadAsync(v1, function(p1, p2) --[[ Line: 171 | Upvalues: v18 (ref), v16 (ref), v17 (ref) ]]
			v18 = v18 + 1
			v16 = math.clamp(v18 / v17, 0, 1)
		end)
		v18 = v17
		v16 = 1
	end
end

local function hideOtherGui(p1) --[[ hideOtherGui | Line: 181 | Upvalues: t3 (ref), t4 (copy) ]]
	if p1.Enabled then
		t3[p1] = p1.Enabled
		p1.Enabled = false
	end

	t4[p1] = p1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 186 | Upvalues: p1 (copy), t3 (ref) ]]
		if not p1.Enabled then
			return
		end

		t3[p1] = p1.Enabled
		p1.Enabled = false
	end)
end

local function hideGuis() --[[ hideGuis | Line: 194 | Upvalues: t3 (ref), v4 (ref), PlayerGui (copy), v1 (ref), t4 (copy) ]]
	t3 = {}
	v4 = PlayerGui.ChildAdded:Connect(function(p1) --[[ Line: 196 | Upvalues: v1 (ref), t3 (ref), t4 (ref) ]]
		if not p1:IsA("ScreenGui") or p1 == v1 then
			return
		end

		if p1.Enabled then
			t3[p1] = p1.Enabled
			p1.Enabled = false
		end

		t4[p1] = p1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 186 | Upvalues: p1 (copy), t3 (ref) ]]
			if not p1.Enabled then
				return
			end

			t3[p1] = p1.Enabled
			p1.Enabled = false
		end)
	end)

	for k, v in pairs(PlayerGui:GetChildren()) do
		if v:IsA("ScreenGui") and v ~= v1 then
			if v.Enabled then
				t3[v] = v.Enabled
				v.Enabled = false
			end

			t4[v] = v:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 186 | Upvalues: v (copy), t3 (ref) ]]
				if not v.Enabled then
					return
				end

				t3[v] = v.Enabled
				v.Enabled = false
			end)
		end
	end
end

local function showGuis() --[[ showGuis | Line: 208 | Upvalues: t4 (copy), v4 (ref), t3 (ref) ]]
	for k, v in pairs(t4) do
		v:Disconnect()
	end

	table.clear(t4)

	if v4 then
		v4:Disconnect()
		v4 = nil
	end

	for k, v in pairs(t3) do
		k.Enabled = v
	end

	table.clear(t3)
end

local function getPlayerPlot() --[[ getPlayerPlot | Line: 223 | Upvalues: LocalPlayer (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if not v1 then
		return nil
	end

	local Gardens = workspace:FindFirstChild("Gardens")

	if Gardens then
		return Gardens:FindFirstChild("Plot" .. v1)
	end

	return nil
end

local function setCam() --[[ setCam | Line: 231 | Upvalues: v10 (ref), LocalPlayer (copy), v11 (ref) ]]
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	workspace.CurrentCamera.FieldOfView = 45

	if not v10 then
		local v1 = LocalPlayer:GetAttribute("PlotId")
		local v2

		if v1 then
			local Gardens = workspace:FindFirstChild("Gardens")

			v2 = if Gardens then Gardens:FindFirstChild("Plot" .. v1) else nil
		else
			v2 = nil
		end

		if v2 then
			local LoadingScreenCam = v2:FindFirstChild("LoadingScreenCam")

			if LoadingScreenCam and LoadingScreenCam:IsA("BasePart") then
				v10 = LoadingScreenCam
			end
		end
	end

	if v10 then
		v11 = true
		workspace.CurrentCamera.CFrame = v10.CFrame

		return
	end

	if v11 then
		return
	end

	workspace.CurrentCamera.CFrame = CFrame.new(239.094, 156.83, -134.733) * CFrame.fromOrientation(-0.2794097599517722, -1.8222633654222395, 0)
end

local function startTransparentBGfx() --[[ startTransparentBGfx | Line: 259 | Upvalues: v7 (ref), ReplicatedStorage (copy), v6 (ref), v5 (ref), Lighting (copy), v9 (ref), setCam (copy), RunService (copy) ]]
	game.Lighting:WaitForChild("DepthOfField").Enabled = false
	v7 = true
	task.spawn(function() --[[ Line: 268 | Upvalues: ReplicatedStorage (ref), v6 (ref), v7 (ref), v5 (ref), Lighting (ref) ]]
		local Blur = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Blur"))

		v6 = Blur

		if v7 then
			Blur.SetBlur(20)
			v5 = Lighting:FindFirstChild("Blur")
		end
	end)
	v9 = true
	task.spawn(function() --[[ Line: 282 | Upvalues: v9 (ref), setCam (ref), RunService (ref) ]]
		while v9 do
			setCam()
			RunService.RenderStepped:Wait()
		end
	end)
end

local function endTransparentBGfx() --[[ endTransparentBGfx | Line: 290 | Upvalues: v7 (ref), v6 (ref), v5 (ref), v9 (ref), v8 (ref) ]]
	workspace.CurrentCamera.FieldOfView = 45
	task.spawn(function() --[[ Line: 292 ]]
		local v1 = os.clock()

		while os.clock() - v1 < 3 do
			workspace.CurrentCamera.FieldOfView = math.clamp((os.clock() - v1) / 3, 0, 1) * 25 + 45
			task.wait()
		end

		workspace.CurrentCamera.FieldOfView = 70
	end)
	v7 = false

	if v6 and v5 then
		v6.SetBlur(0, 1)
	end

	v5 = nil

	if game.Lighting:FindFirstChild("DepthOfField") then
		game.Lighting.DepthOfField.Enabled = true
	end

	v9 = false

	if v8 then
		v8:Disconnect()
		v8 = nil
	end
	-- El cambio a CameraType.Custom se hace al FINAL del intro (handoff
	-- determinista, ya con CameraSubject fijado) para no competir con la
	-- cámara cinemática del skip y evitar que la cámara quede bugeada.
end

local function revealLogo() --[[ revealLogo | Line: 326 | Upvalues: v3 (ref), TweenService (copy) ]]
	local LogoImg = v3:FindFirstChild("LogoImg")

	if LogoImg then
		TweenService:Create(LogoImg, TweenInfo.new(1, Enum.EasingStyle.Linear), {
			ImageTransparency = 0
		}):Play()
		task.wait(1)
	end
end

local function startRotateTween() --[[ startRotateTween | Line: 336 | Upvalues: v3 (ref), v14 (ref), TweenService (copy) ]]
	local LogoImg = v3:FindFirstChild("LogoImg")

	if not LogoImg then
		return
	end

	v14 = TweenService:Create(LogoImg, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, (1 / 0), true), {
		Rotation = 5
	})
	v14:Play()
end

local function stopRotateTween() --[[ stopRotateTween | Line: 345 | Upvalues: v14 (ref) ]]
	if not v14 then
		return
	end

	v14:Pause()
	v14 = nil
end

local function updateTip(p1) --[[ updateTip | Line: 352 | Upvalues: v3 (ref), t5 (ref), shuffleClone (copy), t (copy), TweenService (copy), v13 (ref) ]]
	local TipLabel = v3:FindFirstChild("TipLabel")

	if not TipLabel then
		return
	end

	if #t5 == 0 then
		t5 = shuffleClone(t)
	end

	local v2 = "[" .. table.remove(t5, #t5) .. "]"

	if p1 then
		local v32 = 0.6

		task.spawn(function() --[[ Line: 82 | Upvalues: v32 (copy), TweenService (ref), TipLabel (copy), v13 (ref), v2 (copy) ]]
			local v12 = TweenInfo.new(v32 / 2, Enum.EasingStyle.Linear)
			local v22 = TweenService:Create(TipLabel, v12, {
				TextTransparency = 1
			})

			v22:Play()
			v22.Completed:Wait()

			if v13 then
				return
			end

			TipLabel.Text = v2
			TweenService:Create(TipLabel, v12, {
				TextTransparency = 0
			}):Play()
		end)
	else
		TipLabel.Text = v2
	end
end

local function startTipCycle() --[[ startTipCycle | Line: 364 | Upvalues: t5 (ref), shuffleClone (copy), t (copy), v3 (ref), v12 (ref), TweenService (copy), v13 (ref) ]]
	t5 = shuffleClone(t)

	local TipLabel = v3:FindFirstChild("TipLabel")

	if TipLabel then
		if #t5 == 0 then
			t5 = shuffleClone(t)
		end

		TipLabel.Text = "[" .. table.remove(t5, #t5) .. "]"
	end

	v12 = task.spawn(function() --[[ Line: 368 | Upvalues: v3 (ref), t5 (ref), shuffleClone (ref), t (ref), TweenService (ref), v13 (ref) ]]
		while true do
			local v1

			repeat
				task.wait(7)
				v1 = v3:FindFirstChild("TipLabel")
			until v1

			if #t5 == 0 then
				t5 = shuffleClone(t)
			end

			local v32 = "[" .. table.remove(t5, #t5) .. "]"
			local v4 = 0.6

			task.spawn(function() --[[ Line: 82 | Upvalues: v4 (copy), TweenService (ref), v1 (copy), v13 (ref), v32 (copy) ]]
				local v12 = TweenInfo.new(v4 / 2, Enum.EasingStyle.Linear)
				local v22 = TweenService:Create(v1, v12, {
					TextTransparency = 1
				})

				v22:Play()
				v22.Completed:Wait()

				if v13 then
					return
				end

				v1.Text = v32
				TweenService:Create(v1, v12, {
					TextTransparency = 0
				}):Play()
			end)
		end
	end)
end

local function endTipCycle() --[[ endTipCycle | Line: 376 | Upvalues: v13 (ref), v12 (ref) ]]
	v13 = true

	if not v12 then
		return
	end

	task.cancel(v12)
	v12 = nil
end

local function changeAllTransparency(p1, p2) --[[ changeAllTransparency | Line: 384 | Upvalues: v3 (ref), t2 (copy), TweenService (copy) ]]
	local v1 = TweenInfo.new(p2, Enum.EasingStyle.Linear)

	for k, v in pairs(v3:GetDescendants()) do
		if not v:HasTag("Skip") then
			local v2 = t2[v.ClassName]

			if v2 then
				TweenService:Create(v, v1, {
					[v2] = p1
				}):Play()
			end
		end
	end
end

local function hideFrame() --[[ hideFrame | Line: 398 | Upvalues: changeAllTransparency (copy), TweenService (copy), v2 (ref) ]]
	changeAllTransparency(1, 1)

	local v1 = TweenService:Create(v2, TweenInfo.new(1, Enum.EasingStyle.Linear), {
		BackgroundTransparency = 1
	})

	v1:Play()
	v1.Completed:Wait()
end

local function getLoadingProgress() --[[ getLoadingProgress | Line: 412 | Upvalues: CollectionService (copy), LocalPlayer (copy), v15 (ref), v18 (ref), v17 (ref), v16 (ref) ]]
	if not CollectionService:HasTag(LocalPlayer, "PersistentLoaded") then
		return 0, "Loading player data..."
	end

	if not game:IsLoaded() then
		return 0.05, "Loading game..."
	end

	if not v15 then
		return v16 * 0.2 + 0.05, "Preloading assets... (" .. math.min(v18, v17) .. "/" .. v17 .. ")"
	end

	if not CollectionService:HasTag(LocalPlayer, "ControllersStarted") then
		return 0.25, "Initializing controllers..."
	end

	if not CollectionService:HasTag(LocalPlayer, "DataLoaded") then
		return 0.35, "Loading player save..."
	end

	local v3 = LocalPlayer:GetAttribute("GardenLoadingTotal")
	local v4 = LocalPlayer:GetAttribute("GardenLoadingProgress")

	if v3 and v3 > 0 then
		return math.clamp((v4 or 0) / v3, 0, 1) * 0.55 + 0.45, "Spawning garden... (" .. (v4 or 0) .. "/" .. v3 .. ")"
	end

	return 1, "Ready!"
end

local v19 = nil
local v20 = Instance.new("BindableEvent")
local v21 = 0
local v22 = false
local t6 = { "Polishing fruits...", "Watering gardens...", "Waking up gnomes...", "Planting seeds...", "Counting leaves..." }

local function startCounter() --[[ startCounter | Line: 458 | Upvalues: v3 (ref), TweenService (copy), preloadAssetsAsync (copy), v19 (ref), getLoadingProgress (copy), v21 (ref), v22 (ref), t6 (copy), v20 (copy) ]]
	local CounterTxt = v3:FindFirstChild("CounterTxt")
	local ProgressBar = v3:FindFirstChild("ProgressBar")

	if CounterTxt then
		TweenService:Create(CounterTxt, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
			TextTransparency = 0
		}):Play()
	end

	task.spawn(preloadAssetsAsync)
	v19 = task.spawn(function() --[[ Line: 468 | Upvalues: getLoadingProgress (ref), v21 (ref), v22 (ref), t6 (ref), CounterTxt (copy), ProgressBar (copy), v20 (ref) ]]
		local v1 = 0
		local v2 = 0
		local v3 = 1
		local v4 = "Loading..."

		while true do
			local v5
			local v6, v7 = getLoadingProgress()
			local v8 = os.clock() - v21

			if v6 >= 1 and not v22 then
				v22 = true
			end

			if v22 and v8 < 5 then
				v5 = math.min(v6, (math.max(math.clamp(v8 / 5, 0, 0.95), v1)))

				if v2 == 0 or v8 - v2 >= 3 then
					v7 = t6[v3]
					v3 = v3 % #t6 + 1
					v2 = v8
				else
					v7 = t6[(v3 - 2) % #t6 + 1]
				end
			else
				v5 = v6
			end

			local v13 = math.min(v1 + math.clamp((v5 - v1) * 0.06, 0.001, 0.015), v5, 1)

			if v5 - 0.01 <= v13 then
				v4 = v7
			end

			if CounterTxt then
				game.TweenService:Create(ProgressBar.Bar, TweenInfo.new(0.05), {
					Size = UDim2.new(v13, 0, 1, 0)
				}):Play()
				CounterTxt.Text = v4 .. " " .. math.floor(v13 * 100) .. "%"
			end

			v1 = v13

			if v22 and (v8 >= 5 and v13 >= 0.95) then
				if not CounterTxt then
					game.TweenService:Create(ProgressBar.Bar, TweenInfo.new(0.05), {
						Size = UDim2.new(1, 0, 1, 0)
					}):Play()
					v20:Fire()

					return
				end

				CounterTxt.Text = "Ready! 100%"
				game.TweenService:Create(ProgressBar.Bar, TweenInfo.new(0.05), {
					Size = UDim2.new(1, 0, 1, 0)
				}):Play()
				v20:Fire()

				return
			end

			task.wait(0.05)
		end
	end)
end

local function endCounter() --[[ endCounter | Line: 529 | Upvalues: v19 (ref) ]]
	if not v19 then
		return
	end

	task.cancel(v19)
	v19 = nil
end

(function() --[[ startLoading | Line: 536 | Upvalues: v1 (ref), LocalPlayer (copy), v2 (ref), v3 (ref), ProximityPromptService (copy), startTransparentBGfx (copy), hideGuis (copy), v21 (ref), startRotateTween (copy), t5 (ref), shuffleClone (copy), t (copy), v12 (ref), TweenService (copy), v13 (ref), startCounter (copy), UserInputService (copy), v20 (copy), v22 (ref), v11 (ref), v9 (ref), v7 (ref), v5 (ref), v6 (ref), v19 (ref), hideFrame (copy), endTransparentBGfx (copy), v14 (ref), showGuis (copy) ]]
	local v15 = game.ReplicatedFirst.LoadingScreenMenu:Clone()

	v15.Parent = workspace
	v1 = v15:WaitForChild("LoadingGui", 15)

	local v23 = true

	task.spawn(function() --[[ Line: 544 | Upvalues: v23 (ref), v1 (ref), v15 (copy) ]]
		while v23 do
			game:GetService("RunService").RenderStepped:Wait()

			local v3 = math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 32
			local v4 = v3 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y)

			v1.CanvasSize = workspace.CurrentCamera.ViewportSize
			v15.Size = Vector3.new(v4, v3, 0.1)
			v15.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -16)
		end
	end)

	if v1 then
		v2 = v1:FindFirstChild("Variant1Frame")

		if not v2 then
			v1.Enabled = false
		else
			v3 = v2:FindFirstChild("InnerFrame")

			if not v3 then
				v1.Enabled = false
			else
				LocalPlayer:SetAttribute("LoadingScreenActive", true)
				ProximityPromptService.Enabled = false

				local v32 = false

				local function anchorCharacter(p1) --[[ anchorCharacter | Line: 586 | Upvalues: v32 (ref) ]]
					if v32 then
						return
					end

					local v1 = p1:FindFirstChild("HumanoidRootPart") or p1:WaitForChild("HumanoidRootPart", 10)

					if v32 then
						return
					end

					if not (v1 and v1:IsA("BasePart")) then
						return
					end

					v1.Anchored = true
				end

				local Character = LocalPlayer.Character

				if Character then
					Character:FindFirstChild("HumanoidRootPart")
				end

				if Character then
					task.spawn(anchorCharacter, Character)
				end

				local v4 = LocalPlayer.CharacterAdded:Connect(anchorCharacter)

				startTransparentBGfx()
				hideGuis()
				v1.Enabled = true
				v2.Visible = true
				v21 = os.clock()
				startRotateTween()
				t5 = shuffleClone(t)

				local TipLabel = v3:FindFirstChild("TipLabel")

				if TipLabel then
					if #t5 == 0 then
						t5 = shuffleClone(t)
					end

					TipLabel.Text = "[" .. table.remove(t5, #t5) .. "]"
				end

				v12 = task.spawn(function() --[[ Line: 368 | Upvalues: v3 (ref), t5 (ref), shuffleClone (ref), t (ref), TweenService (ref), v13 (ref) ]]
					while true do
						local v1

						repeat
							task.wait(7)
							v1 = v3:FindFirstChild("TipLabel")
						until v1

						if #t5 == 0 then
							t5 = shuffleClone(t)
						end

						local v32 = "[" .. table.remove(t5, #t5) .. "]"
						local v4 = 0.6

						task.spawn(function() --[[ Line: 82 | Upvalues: v4 (copy), TweenService (ref), v1 (copy), v13 (ref), v32 (copy) ]]
							local v12 = TweenInfo.new(v4 / 2, Enum.EasingStyle.Linear)
							local v22 = TweenService:Create(v1, v12, {
								TextTransparency = 1
							})

							v22:Play()
							v22.Completed:Wait()

							if v13 then
								return
							end

							v1.Text = v32
							TweenService:Create(v1, v12, {
								TextTransparency = 0
							}):Play()
						end)
					end
				end)
				startCounter()

				local v62 = false
				local v72 = false
				local v8 = false
				local SkipTxt = v3:FindFirstChild("SkipTxt")
				local v92 = UserInputService.InputBegan:Connect(function() --[[ Line: 621 | Upvalues: v8 (ref), v62 (ref) ]]
					if not v8 then
						return
					end

					v62 = true
				end)

				v20.Event:Connect(function() --[[ Line: 627 | Upvalues: v72 (ref), v3 (ref), TweenService (ref), v13 (ref), SkipTxt (copy) ]]
					v72 = true

					local CounterTxt = v3:FindFirstChild("CounterTxt")

					if CounterTxt then
						local v1 = 0.6
						local v2 = "Fully Loaded!"

						task.spawn(function() --[[ Line: 82 | Upvalues: v1 (copy), TweenService (ref), CounterTxt (copy), v13 (ref), v2 (copy) ]]
							local v12 = TweenInfo.new(v1 / 2, Enum.EasingStyle.Linear)
							local v22 = TweenService:Create(CounterTxt, v12, {
								TextTransparency = 1
							})

							v22:Play()
							v22.Completed:Wait()

							if v13 then
								return
							end

							CounterTxt.Text = v2
							TweenService:Create(CounterTxt, v12, {
								TextTransparency = 0
							}):Play()
						end)
					end

					if not SkipTxt then
						return
					end

					local v32 = SkipTxt
					local v4 = 0.6
					local v5 = ""

					task.spawn(function() --[[ Line: 82 | Upvalues: v4 (copy), TweenService (ref), v32 (copy), v13 (ref), v5 (copy) ]]
						local v12 = TweenInfo.new(v4 / 2, Enum.EasingStyle.Linear)
						local v22 = TweenService:Create(v32, v12, {
							TextTransparency = 1
						})

						v22:Play()
						v22.Completed:Wait()

						if v13 then
							return
						end

						v32.Text = v5
						TweenService:Create(v32, v12, {
							TextTransparency = 0
						}):Play()
					end)
				end)

				local function v() --[[ elapsedTime | Line: 638 | Upvalues: v21 (ref) ]]
					return os.clock() - v21
				end

				while not v72 do
					if not v8 and (v22 and (v11 and os.clock() - v21 >= 0)) then
						v8 = true

						if SkipTxt then
							local v10 = 0.6
							local v112 = "Click to skip!"

							task.spawn(function() --[[ Line: 82 | Upvalues: v10 (copy), TweenService (ref), SkipTxt (copy), v13 (ref), v112 (copy) ]]
								local v12 = TweenInfo.new(v10 / 2, Enum.EasingStyle.Linear)
								local v22 = TweenService:Create(SkipTxt, v12, {
									TextTransparency = 1
								})

								v22:Play()
								v22.Completed:Wait()

								if v13 then
									return
								end

								SkipTxt.Text = v112
								TweenService:Create(SkipTxt, v12, {
									TextTransparency = 0
								}):Play()
							end)
						end
					end

					if v62 then
						break
					end

					task.wait()
				end

				pcall(function() --[[ Line: 657 ]]
					game.SoundService.SFX.Click:Play()
				end)

				if v72 then
					local v142 = "<font color=\'#FFFF00\'>[" .. (if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then "Tap anywhere to play!" else "Press any key to play!") .. "]</font>"
					local PressAnyTxt = v3:FindFirstChild("PressAnyTxt")

					if PressAnyTxt then
						local v152 = 0.6

						task.spawn(function() --[[ Line: 82 | Upvalues: v152 (copy), TweenService (ref), PressAnyTxt (copy), v13 (ref), v142 (copy) ]]
							local v12 = TweenInfo.new(v152 / 2, Enum.EasingStyle.Linear)
							local v22 = TweenService:Create(PressAnyTxt, v12, {
								TextTransparency = 1
							})

							v22:Play()
							v22.Completed:Wait()

							if v13 then
								return
							end

							PressAnyTxt.Text = v142
							TweenService:Create(PressAnyTxt, v12, {
								TextTransparency = 0
							}):Play()
						end)
					end

					v8 = true

					while not v62 do
						task.wait()
					end
				end

				v23 = false
				v9 = false

				local v16 = false

				task.spawn(function() --[[ Line: 680 | Upvalues: v7 (ref), v5 (ref), v6 (ref), LocalPlayer (ref), v16 (ref) ]]
					local sum = 0
					local v1 = workspace.CurrentCamera.CFrame
					local v2 = v1 * CFrame.new(0, -5, -35)
					local v3 = false

					v7 = false
					v5 = nil

					if v6 then
						v6.SetBlur(0, 1.8)
					end

					while sum < 2.2 do
						local v4

						sum = sum + game:GetService("RunService").Heartbeat:Wait()

						if sum > 1.8 and not v3 then
							game.SoundService.SFX.Whoosh:Play()
							v3 = true
						end

						local function lerp(p1, p2, p3) --[[ lerp | Line: 709 ]]
							return p1 + (p2 - p1) * p3
						end

						if sum < 1.8 then
							local v52 = sum / 1.8

							workspace.CurrentCamera.FieldOfView = 45 + 5 * game.TweenService:GetValue(v52, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
							v4 = v52 ^ 4 * 0.08
						elseif sum < 2.2 then
							local v62 = (sum - 1.8) / 0.4

							workspace.CurrentCamera.FieldOfView = 55 + -15 * game.TweenService:GetValue(v62, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
							v4 = v62 * v62 * (3 - v62 * 2) * 0.92 + 0.08
						else
							v4 = 1
						end

						workspace.CurrentCamera.CFrame = v1:Lerp(v2, v4)
					end

					local v72 = CFrame.new(0, 4.70700073, 12.081604, 1, 1.47265382e-8, -5.58793545e-8, -6.82366663e-12, 0.966528356, 0.256560236, 5.77419996e-8, -0.256560266, 0.966528296)
					local Character = LocalPlayer.Character
					local v8 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

					if v8 and v8:IsA("BasePart") then
						local v9 = game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							CFrame = v8.CFrame * v72
						})

						v9:Play()
						v9.Completed:Wait()
					end

					v16 = true
				end)

				if v19 then
					task.cancel(v19)
					v19 = nil
				end

				v13 = true

				if v12 then
					task.cancel(v12)
					v12 = nil
				end

				v92:Disconnect()
				hideFrame()
				task.wait(1)
				task.wait(0.6)
				endTransparentBGfx()

				if v14 then
					v14:Pause()
					v14 = nil
				end

				showGuis()
				LocalPlayer:SetAttribute("LoadingScreenActive", false)

				local v17 = os.clock()

				while not v16 and os.clock() - v17 < 2 do
					task.wait()
				end

				v32 = true

				if v4 then
					v4:Disconnect()
				end

				local Character2 = LocalPlayer.Character
				local v18 = Character2 and Character2:FindFirstChild("HumanoidRootPart")

				if v18 then
					local v192 = LocalPlayer:GetAttribute("PlotId")
					local v202

					if v192 then
						local Gardens = workspace:FindFirstChild("Gardens")

						v202 = if Gardens then Gardens:FindFirstChild("Plot" .. v192) else nil
					else
						v202 = nil
					end

					local v212 = if v202 then v202:FindFirstChild("SpawnPoint") else v202

					if v212 then
						Character2:PivotTo(v212.CFrame)
					end

					v18.Anchored = false
				end

				-- Handoff de cámara determinista: durante todo el intro la cámara
				-- estuvo Scriptable (cinemática). Aquí, ya con el personaje en su
				-- spawn y desanclado, fijamos CameraSubject al Humanoid ANTES de
				-- volver a Custom para que la cámara siga al jugador siempre y no
				-- quede bugeada al hacer skip (la carrera anterior la dejaba sin sujeto).
				do
					local cam = workspace.CurrentCamera
					local char = LocalPlayer.Character
					local humanoid = char and char:FindFirstChildOfClass("Humanoid")
					if humanoid then
						cam.CameraSubject = humanoid
					end
					cam.CameraType = Enum.CameraType.Custom
				end

				ProximityPromptService.Enabled = true
				v1.Enabled = false
				v15:Destroy()
			end
		end
	end

	LocalPlayer:SetAttribute("LoadingScreenDone", true)
end)()