local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)

require(ReplicatedStorage.Datas.Index)

local TsunamiWaveModelFolder = ReplicatedStorage.Models.TsunamiWaves
local TsunamiWaveNameList = {}

for _, WaveModel in TsunamiWaveModelFolder:GetChildren() do
	local WaveName = WaveModel.Name
	table.insert(TsunamiWaveNameList, WaveName)
end

return ConchModule.register_type(
	"Tsunami Wave",
	ConchModule.args.enum_new(TsunamiWaveNameList)
)