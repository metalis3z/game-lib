-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Conversions = require(script.Conversions)
local t = {}

t.__index = t
t.C = 299792458
t.R = 8.314
t.GravityAcceleration = 9.8
t.Avogadro = 6.0221417900000006e23
t.Conversions = Conversions
function t.getVelocityAtTime(p1, p2, p3) --[[ getVelocityAtTime | Line: 113 ]]
	return p1 + p2 * p3
end
function t.getInitialVelocity(p1, p2, p3) --[[ getInitialVelocity | Line: 121 ]]
	return p1 - p2 * p3
end
function t.getAcceleration(p1, p2, p3) --[[ getAcceleration | Line: 129 ]]
	return (p2 - p1) / p3
end
function t.getTimeSinceInitialVelocity(p1, p2, p3) --[[ getTimeSinceInitialVelocity | Line: 137 ]]
	return (p2 - p1) / p3
end
function t.getDistanceAtTime(p1, p2, p3) --[[ getDistanceAtTime | Line: 145 ]]
	return p3 * (p1 + p2) / 2
end
function t.getTimeAtDistance(p1, p2, p3) --[[ getTimeAtDistance | Line: 153 ]]
	return p3 / ((p1 + p2) / 2)
end
function t.getInitialVelocityFromDistance(p1, p2, p3) --[[ getInitialVelocityFromDistance | Line: 157 ]]
	return p3 * p1 * 2 - p2
end
function t.getVelocityFromDistance(p1, p2, p3) --[[ getVelocityFromDistance | Line: 165 ]]
	return p3 * p1 * 2 - p2
end
function t.getDistanceAtTimeFromInitialVelocityAndAcceleration(p1, p2, p3) --[[ getDistanceAtTimeFromInitialVelocityAndAcceleration | Line: 173 ]]
	return p2 * p1 + 0.5 * p3 * p1 ^ 2
end
function t.getInitialVelocityAtTimeFromDistanceAndAcceleration(p1, p2, p3) --[[ getInitialVelocityAtTimeFromDistanceAndAcceleration | Line: 181 ]]
	return (p2 - 0.5 * p3 * p1 ^ 2) / p1
end
function t.getTimeAtDistanceFromInitialVelocityAndAcceleration(p1, p2, p3) --[[ getTimeAtDistanceFromInitialVelocityAndAcceleration | Line: 189 ]]
	return (p2 - p1) * 2 / p3
end
function t.getAccelerationAtDistanceFromInitialVelocityAndTime(p1, p2, p3) --[[ getAccelerationAtDistanceFromInitialVelocityAndTime | Line: 197 ]]
	return (p2 - p1 * p3) * 2 / p3 ^ 2
end
function t.getVelocityAtDistanceFromInitialVelocityAndAcceleration(p1, p2, p3) --[[ getVelocityAtDistanceFromInitialVelocityAndAcceleration | Line: 205 ]]
	return (p1 ^ 2 + 2 * p3 * p2) ^ 0.5
end
function t.getInitialVelocityAtDistanceFromVelocityAndAcceleration(p1, p2, p3) --[[ getInitialVelocityAtDistanceFromVelocityAndAcceleration | Line: 213 ]]
	return (p1 ^ 2 - 2 * p3 * p2) ^ 0.5
end
function t.getDistanceAtVelocityFromInitialVelocityAndAcceleration(p1, p2, p3) --[[ getDistanceAtVelocityFromInitialVelocityAndAcceleration | Line: 221 ]]
	return (p1 ^ 2 - p2 ^ 2) / (2 * p3)
end
function t.getAccelerationAtVelocityFromInitialVelocityAndDistance(p1, p2, p3) --[[ getAccelerationAtVelocityFromInitialVelocityAndDistance | Line: 229 ]]
	return (p1 ^ 2 - p2 ^ 2) / (2 * p3)
end
function t.getForce(p1, p2) --[[ getForce | Line: 237 ]]
	return p1 * p2
end
function t.getMassFromForce(p1, p2) --[[ getMassFromForce | Line: 241 ]]
	return p1 / p2
end
function t.getAccelerationFromForce(p1, p2) --[[ getAccelerationFromForce | Line: 245 ]]
	return p1 / p2
end
function t.getKineticEnergy(p1, p2) --[[ getKineticEnergy | Line: 249 ]]
	return 0.5 * p1 * p2 ^ 2
end
function t.getMassFromKineticEnergyAndVelocity(p1, p2) --[[ getMassFromKineticEnergyAndVelocity | Line: 253 ]]
	return 2 * p2 / p1 ^ 2
end
function t.getVelocityFromKineticEnergyAndMass(p1, p2) --[[ getVelocityFromKineticEnergyAndMass | Line: 257 ]]
	return (p2 * 2 / p1) ^ 0.5
end
function t.getMomentum(p1, p2) --[[ getMomentum | Line: 261 ]]
	return p1 * p2
end
function t.getVelocityFromMomentumAndMass(p1, p2) --[[ getVelocityFromMomentumAndMass | Line: 265 ]]
	return p2 / p1
end
function t.getMassFromMomentumAndVelocity(p1, p2) --[[ getMassFromMomentumAndVelocity | Line: 269 ]]
	return p2 / p1
end
function t.getWork(p1, p2) --[[ getWork | Line: 273 ]]
	return p1 * p2
end
function t.getForceFromWorkAndDistance(p1, p2) --[[ getForceFromWorkAndDistance | Line: 277 ]]
	return p1 / p2
end
function t.getDistanceFromWorkAndForce(p1, p2) --[[ getDistanceFromWorkAndForce | Line: 281 ]]
	return p1 / p2
end
function t.getPower(p1, p2) --[[ getPower | Line: 285 ]]
	return p1 / p2
end
function t.getPowerFromForceAndVelocity(p1, p2) --[[ getPowerFromForceAndVelocity | Line: 289 ]]
	return p1 * p2
end
function t.getVelocityFromPowerAndForce(p1, p2) --[[ getVelocityFromPowerAndForce | Line: 293 ]]
	return p2 / p1
end
function t.getForceFromPowerAndVelocity(p1, p2) --[[ getForceFromPowerAndVelocity | Line: 297 ]]
	return p2 / p1
end
function t.getWorkFromPowerAndTime(p1, p2) --[[ getWorkFromPowerAndTime | Line: 301 ]]
	return p1 * p2
end
function t.getTimeFromPowerAndWork(p1, p2) --[[ getTimeFromPowerAndWork | Line: 305 ]]
	return p2 / p1
end
function t.getVoltage(p1, p2) --[[ getVoltage | Line: 309 ]]
	return p1 * p2
end
function t.getResistance(p1, p2) --[[ getResistance | Line: 313 ]]
	return p1 / p2
end
function t.getCurrent(p1, p2) --[[ getCurrent | Line: 317 ]]
	return p1 / p2
end
function t.getDragForce(p1, p2, p3, p4) --[[ getDragForce | Line: 321 ]]
	return 0.5 * p1 * p2 ^ 2 * p4 * p3
end
function t.getDragCoefficient(p1, p2, p3, p4) --[[ getDragCoefficient | Line: 330 ]]
	return p4 / (0.5 * p1 * p2 ^ 2 * p3)
end
function t.getDragArea(p1, p2, p3, p4) --[[ getDragArea | Line: 339 ]]
	return p4 / (0.5 * p1 * p2 ^ 2 * p3)
end
function t.getDragVelocity(p1, p2, p3, p4) --[[ getDragVelocity | Line: 348 ]]
	return (p4 / (0.5 * p1 * p3 * p2)) ^ 0.5
end
function t.getDragFluidDensity(p1, p2, p3, p4) --[[ getDragFluidDensity | Line: 357 ]]
	return p4 / (p3 * 0.5 * p1 ^ 2 * p3)
end
function t.getFrictionForce(p1, p2) --[[ getFrictionForce | Line: 366 ]]
	return p1 * p2
end
function t.getFrictionCoefficient(p1, p2) --[[ getFrictionCoefficient | Line: 370 ]]
	return p1 / p2
end
function t.getFrictionNormalForce(p1, p2) --[[ getFrictionNormalForce | Line: 374 ]]
	return p1 / p2
end
function t.getPressureFromAreaAndForce(p1, p2) --[[ getPressureFromAreaAndForce | Line: 378 ]]
	return p1 / p2
end
function t.getPressureFromVolumeAndTemperatureAndAtoms(p1, p2, p3) --[[ getPressureFromVolumeAndTemperatureAndAtoms | Line: 382 | Upvalues: t (copy) ]]
	return p2 * t.R * p3 / p1
end
function t.getTemperatureFromVolumeAndPressureAndAtoms(p1, p2, p3) --[[ getTemperatureFromVolumeAndPressureAndAtoms | Line: 390 | Upvalues: t (copy) ]]
	return p3 * p1 / (p2 * t.R)
end
function t.getVolumeFromTemperatureAndPressureAndAtoms(p1, p2, p3) --[[ getVolumeFromTemperatureAndPressureAndAtoms | Line: 398 | Upvalues: t (copy) ]]
	return p1 * t.R * p3 / p2
end
function t.getAtomCountFromTemperatureAndPressureAndVolume(p1, p2, p3) --[[ getAtomCountFromTemperatureAndPressureAndVolume | Line: 406 | Upvalues: t (copy) ]]
	return p2 * p1 / (t.R * p3)
end
function t.getHeatEnergy(p1, p2, p3) --[[ getHeatEnergy | Line: 414 ]]
	return p1 * p2 * p3
end
function t.getHeatCapacity(p1, p2, p3) --[[ getHeatCapacity | Line: 418 ]]
	return p2 / (p1 * p3)
end
function t.getDeltaTemperature(p1, p2, p3) --[[ getDeltaTemperature | Line: 422 ]]
	return p2 / (p1 * p3)
end
function t.getMassFromDeltaTemperatureAndHeatEnergyAndHeatCapacity(p1, p2, p3) --[[ getMassFromDeltaTemperatureAndHeatEnergyAndHeatCapacity | Line: 426 ]]
	return p2 / (p1 * p3)
end

return t