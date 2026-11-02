local WinterHour = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/WinterHour/Burst")

local IsActive = false
local StrikeTask = nil
local RecentlyTargeted = setmetatable({}, { __mode = "k" })

local Winterate = workspace.Events["Winter Hour"].Model

local HatIdleAnimation = nil
local SequenceAnimation = nil

local function UpdateWinteratePosition()
	if ReplicatedStorage:GetAttribute("StockEvent") then
		Winterate:PivotTo(CFrame.new(-382.542, -9.522, -3.997))
	else
		Winterate:PivotTo(CFrame.new(-381.109, -9.5, 17.906))
	end
end

local function SetupIdleAnimation()
	local Sammy = Winterate:FindFirstChild("Sammy")
	if not Sammy then return end

	local Humanoid = Sammy:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")
	if not Animator then
		Animator = Instance.new("Animator")
		Animator.Parent = Humanoid
	end

	local Anim = ReplicatedStorage.Controllers.EventController.Events["Winter Hour"]:FindFirstChild("HatIdle")
	if not Anim then return end

	if HatIdleAnimation then
		HatIdleAnimation:Stop()
	end

	HatIdleAnimation = Animator:LoadAnimation(Anim)
	HatIdleAnimation.Looped = true
	HatIdleAnimation.Priority = Enum.AnimationPriority.Idle
	HatIdleAnimation:Play()
end

local function PlaySequenceAnimation()
	local Sammy = Winterate:FindFirstChild("Sammy")
	if not Sammy then return end

	local Humanoid = Sammy:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")
	if not Animator then
		Animator = Instance.new("Animator")
		Animator.Parent = Humanoid
	end

	local Anim = ReplicatedStorage.Controllers.EventController.Events["Winter Hour"]:FindFirstChild("Sequence")
	if not Anim then return end

	if HatIdleAnimation then
		HatIdleAnimation:Stop()
	end
	if SequenceAnimation then
		SequenceAnimation:Stop()
	end

	SequenceAnimation = Animator:LoadAnimation(Anim)
	SequenceAnimation.Priority = Enum.AnimationPriority.Action
	SequenceAnimation:Play()

	SequenceAnimation.Stopped:Once(function()
		if IsActive then
			SetupIdleAnimation()
		end
	end)
end

local function SetSantaHatVisibility(State)
	local Sammy = Winterate:FindFirstChild("Sammy")
	if not Sammy then return end

	local Hat = Sammy:FindFirstChild("Santa's Hat")
	if not Hat then return end

	for _, V in ipairs(Hat:GetDescendants()) do
		if V:IsA("BasePart") or V:IsA("MeshPart") then
			V.Transparency = State and 0 or 1
		end
	end
end

SetupIdleAnimation()
SetSantaHatVisibility(false)

ReplicatedStorage:GetAttributeChangedSignal("StockEvent"):Connect(function()
	if IsActive then
		UpdateWinteratePosition()
	end
end)

function WinterHour.OnStart()
	if IsActive then return end

	IsActive = true
	ReplicatedStorage:SetAttribute("WinterHourEvent", true)

	UpdateWinteratePosition()

	SetSantaHatVisibility(true)
	SetupIdleAnimation()

	if StrikeTask then
		task.cancel(StrikeTask)
	end

	StrikeTask = task.spawn(function()
		while IsActive do
			task.wait(math.random(60, 100) / 10)
			if not IsActive then break end

			local Sammy = Winterate:FindFirstChild("Sammy")
			if not Sammy or not Sammy.PrimaryPart then continue end

			local SammyPos = Sammy.PrimaryPart.Position
			local Now = workspace:GetServerTimeNow()

			for Animal, T in pairs(RecentlyTargeted) do
				if Now - T > 15 then
					RecentlyTargeted[Animal] = nil
				end
			end

			local TargetAnimal
			local BestDist = math.huge

			for _, Animal in ipairs(CollectionService:GetTagged("Animal")) do
				if Animal.PrimaryPart and not RecentlyTargeted[Animal] then
					local Dist = (Animal.PrimaryPart.Position - SammyPos).Magnitude
					if Dist <= 50 then
						local HasHat = false
						local Raw = Animal:GetAttribute("Traits")

						if Raw then
							local Ok, Decoded = pcall(HttpService.JSONDecode, HttpService, Raw)
							if Ok and type(Decoded) == "table" then
								for _, Trait in ipairs(Decoded) do
									if Trait == "Santa Hat" then
										HasHat = true
										break
									end
								end
							end
						end

						if not HasHat and Dist < BestDist then
							BestDist = Dist
							TargetAnimal = Animal
						end
					end
				end
			end

			if TargetAnimal then
				RecentlyTargeted[TargetAnimal] = Now
				PlaySequenceAnimation()

				task.delay(0.5, function()
					if not IsActive or not TargetAnimal or not TargetAnimal.Parent then
						return
					end

				local _raw = TargetAnimal:GetAttribute("Traits") or "[]"
				local _ok, _traits = pcall(game:GetService("HttpService").JSONDecode, game:GetService("HttpService"), _raw)
				if _ok and type(_traits) == "table" then
					local _has = false
					for _, _t in ipairs(_traits) do if _t == "Santa Hat" then _has = true break end end
					if not _has then
						table.insert(_traits, "Santa Hat")
						TargetAnimal:SetAttribute("Traits", game:GetService("HttpService"):JSONEncode(_traits))
					end
				end

				end)
		end
		end
	end)
end

function WinterHour.OnStop()
	if not IsActive then return end

	IsActive = false
	ReplicatedStorage:SetAttribute("WinterHourEvent", false)

	if StrikeTask then
		task.cancel(StrikeTask)
		StrikeTask = nil
	end

	if HatIdleAnimation then
		HatIdleAnimation:Stop()
		HatIdleAnimation = nil
	end

	if SequenceAnimation then
		SequenceAnimation:Stop()
		SequenceAnimation = nil
	end

	RecentlyTargeted = setmetatable({}, { __mode = "k" })

	SetSantaHatVisibility(false)

	Winterate:PivotTo(CFrame.new(0, 100000, 0))
end

return WinterHour
