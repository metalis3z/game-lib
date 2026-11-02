local SkinService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ServerStorage = game:GetService("ServerStorage")

local IndexData = require(ReplicatedStorage.Datas.Index)
local BasesData = require(ReplicatedStorage.Datas.Bases)

local ExcludedRoots = {
	"Laser",
	"LaserHitbox",
	"Purchases",
	"AnimalPodiums",
	"PlotSign",
	"FriendPanel",
	"CashPad",
	"Model"
}

local function IsExcluded(Part, Plot)
	for _, RootName in ipairs(ExcludedRoots) do
		local RootObject = Plot:FindFirstChild(RootName)
		if RootObject and (Part:IsDescendantOf(RootObject) or Part == RootObject) then
			return true
		end
	end
	return false
end

local function HasColorIgnoreTag(Part, MutationName)
	if CollectionService:HasTag(Part, "IgnoreColor") then
		return true
	end

	if CollectionService:HasTag(Part, "BaseGround") and MutationName ~= "YinYang" then
		return true
	end

	return false
end

local function AdjustOriginalColor(Color)
	local Red = math.floor(Color.R * 255)
	local Green = math.floor(Color.G * 255)
	local Blue = math.floor(Color.B * 255)

	if (Red == 0 and Green == 195 and Blue == 0)
		or (Red == 196 and Green == 40 and Blue == 28) then
		return Color3.fromRGB(140, 140, 140)
	end

	return Color
end

local function ReplaceSkin(Plot, MutationName)
	local SkinsFolder = script:FindFirstChild("Skins")
	if not SkinsFolder then return end

	local MutationFolder = SkinsFolder:FindFirstChild(MutationName)
	if not MutationFolder then return end

	local Tier = Plot:GetAttribute("Tier") or 0
	local BaseInformation = BasesData[Tier]
	if not BaseInformation or not BaseInformation.Model then return end

	local FloorName = BaseInformation.Model.Name
	local FloorModel = MutationFolder:FindFirstChild(FloorName)

	if not FloorModel then
		for _, ModelObject in ipairs(MutationFolder:GetChildren()) do
			if ModelObject:IsA("Model") then
				FloorModel = ModelObject
				break
			end
		end
	end

	if not FloorModel then return end

	local PreviousSkinFolder = Plot:FindFirstChild("Skin")
	local PreviousPivotCFrame

	if PreviousSkinFolder then
		local PreviousModel = PreviousSkinFolder:FindFirstChildWhichIsA("Model")
		if PreviousModel then
			PreviousPivotCFrame = PreviousModel:GetPivot()
		end
		PreviousSkinFolder:Destroy()
	end

	local NewSkinFolder = Instance.new("Folder")
	NewSkinFolder.Name = "Skin"
	NewSkinFolder.Parent = Plot

	local ClonedFloorModel = FloorModel:Clone()
	ClonedFloorModel.Parent = NewSkinFolder

	local RootPart = Plot:FindFirstChild("Root")
	local BaseCFrame =
		(RootPart and RootPart.CFrame)
		or PreviousPivotCFrame
		or Plot:GetPivot()

	local VerticalOffset = 0
	if MutationName == "Aquatic" then
		VerticalOffset = -0.6
	end

	ClonedFloorModel:PivotTo(BaseCFrame * CFrame.new(0, VerticalOffset, 0))

	local HeartbeatConnection
	HeartbeatConnection = RunService.Heartbeat:Connect(function()
		if not ClonedFloorModel or not ClonedFloorModel.Parent then
			if HeartbeatConnection then
				HeartbeatConnection:Disconnect()
			end
			return
		end

		if RootPart then
			local UpdatedCFrame =
				RootPart.CFrame * CFrame.new(0, VerticalOffset, 0)
			ClonedFloorModel:PivotTo(UpdatedCFrame)
		end
	end)

	if not Plot:GetAttribute("Player") and _G.playerPlots then
		for UserId, PlayerPlot in pairs(_G.playerPlots) do
			if PlayerPlot == Plot then
				local Player = game.Players:GetPlayerByUserId(UserId)
				if Player then
					Plot:SetAttribute("Player", Player.Name)
				end
			end
		end
	end
end

function SkinService:Apply(MutationName, Plot)
	local MutationData = IndexData[MutationName]

	if not MutationData
		and MutationName ~= "Normal"
		and MutationName ~= "Rainbow" then
		return
	end

	if MutationName == "Normal" then
		return
	end

	if MutationName == "Aquatic" or MutationName == "Halloween" then
		local SpecialMutationData = IndexData[MutationName]

		ReplaceSkin(Plot, MutationName)

		if SpecialMutationData and SpecialMutationData.BaseColors then
			for _, Part in ipairs(Plot:GetDescendants()) do
				if Part:IsA("BasePart")
					and not IsExcluded(Part, Plot)
					and not HasColorIgnoreTag(Part, MutationName) then

					local ColorVector = Vector3.new(
						math.floor(Part.Color.R * 255),
						math.floor(Part.Color.G * 255),
						math.floor(Part.Color.B * 255)
					)

					local NewColor =
						SpecialMutationData.BaseColors[ColorVector]

					if NewColor then
						Part.Color = NewColor
					end
				end
			end
		end
		return
	end

	if MutationName == "Rainbow" then
		for _, Part in ipairs(Plot:GetDescendants()) do
			if Part:IsA("BasePart")
				and not IsExcluded(Part, Plot)
				and not HasColorIgnoreTag(Part, MutationName) then

				if not CollectionService:HasTag(Part, "RainbowModel") then
					CollectionService:AddTag(Part, "RainbowModel")
				end

				if not CollectionService:HasTag(Part, "RainbowDarken") then
					CollectionService:AddTag(Part, "RainbowDarken")
				end
			end
		end
		return
	end

	for _, Part in ipairs(Plot:GetDescendants()) do
		if Part:IsA("BasePart")
			and not IsExcluded(Part, Plot)
			and not HasColorIgnoreTag(Part, MutationName) then

			local ColorVector = Vector3.new(
				math.floor(Part.Color.R * 255),
				math.floor(Part.Color.G * 255),
				math.floor(Part.Color.B * 255)
			)

			local NewColor =
				MutationData.BaseColors
				and MutationData.BaseColors[ColorVector]

			if NewColor then
				Part.Color = NewColor
			end
		end
	end
end

return SkinService