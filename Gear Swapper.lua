--[[SND Metadata]]
author: Ksirashi (Eclipse)
version: 2.1.0
description: Swaps your gearset depending on zone you are in. Make sure to tick OnTerritoryChange trigger in Macro Settings
--[[End Metadata]]

local currentZone = tostring(Svc.ClientState.TerritoryType)

if Addons.GetAddon("NowLoading").Ready then
    while Addons.GetAddon("NowLoading").Ready do
        yield("/wait 1")
    end
end
--**********[Config]************
local ZoneConfig = {-- insert zones here that you want to swap gear in
    occult = {"1252"}, --South horn
    ultimate = {"733", "777", "887", "968", "1122", "1238"} -- UCOB, UwU, TEA, DSR, TOP, FRU
--    savage = {"1257", "1259", "1261", "1263", "1271"} --M5-M8, Zelenia
}

local JobGearsets = { --insert your gearsets here
--19 PLD, 21 WAR, 32 DRK, 37 GNB
--24 WHM, 28 SCH, 33 AST, 40 SGE
--20 MNK. 22 DRG 30 NIN, 34 SAM, 39 RPR, 41 VPR
--23 BRD, 31 MCH, 38 DNC
--25 BLM, 27 SMN. 35 RDM, 42 PCT
    [21] = {
        normal = "Warrior",
        occult = "Warrior Occult"
    },
    [40] = {
        normal = "Sage",
        ultimate = "Sage TOP"
    },
    [28] = {
        normal = "Scholar",
        occult = "Scholar Occult",
        ultimate = "Scholar TOP"
    }
}
--********************************

local currentJobID = Player.Job.Id
if not JobGearsets[currentJobID] then
    return
end

local function GetGearsetType(zone)
    for gType, zones in pairs(ZoneConfig) do
            for _, z in ipairs(zones) do
                if zone == z then
                    return gType
                end
            end
    end
    return "normal"
end

local currentJobID = Player.Job.Id
local gearsetType = GetGearsetType(currentZone)
local GearsetName = JobGearsets[currentJobID] and JobGearsets[currentJobID][gearsetType]

local currentGearset = Player.Gearset.Name
if currentGearset ~= GearsetName then --change to ==, if you remove comments
--    yield("/echo [Gear swapper] You alread in right gearset: ("..GearsetName..")")
--else
    yield("/echo [Gear swapper] Changing gear to: "..GearsetName)
    yield("/gs change \""..GearsetName.."\"")
end
