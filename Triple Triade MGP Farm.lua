--[=====[
[[SND Metadata]]
author: Ksirashi
version: 4
description: >-
  TPs to Mor Dhona, flies to Klynthota and plays cards until target amount,

  then TPs to Gold Saucer and sells cards. Script assumes you already have

  all the NPC dialogue skips via YesAlready or TextAdvance and deck in Saucy set up.

  Do not forget to set up ShopCardDialog in Bothers in YesAlready.
plugin_dependencies:
- vnavmesh
- Saucy
- Lifestream
- YesAlready
function_chat_filters:
  OnChatMessage:
    channels:
      - LootNotice
    message_regex: "^You obtain (.+?) MGP.$"
[[End Metadata]]
--]=====]

-- ===================CONFIIIIIIG===================
local UserConfig = {
    targetMGP = "999999999", --put how many MGP you want here.
    targetCards = "99999999" --put how many cards you want here.
-- Leave both empty for it to play exactly 1 match.
-- it stops when either of them reaches target amount
}
-- ===================CONFIIIIIIG===================


local MGP = UserConfig.targetMGP ~= "" and tonumber(UserConfig.targetMGP)
local Cards = UserConfig.targetCards ~= "" and tonumber(UserConfig.targetCards)
local CardUICategory = 86
local Bags = {InventoryType.Inventory1, InventoryType.Inventory2, InventoryType.Inventory3, InventoryType.Inventory4}
local MatchFinished = false

function OnChatMessage()
    MatchFinished = true
end

function GetCardCount()
    local total = 0
    local itemSheet = Excel.GetSheet("Item")
    for _, bag in ipairs(Bags) do
        for slot = 1, 35 do
            local item = Inventory.GetInventoryItemBySlot(bag, slot)
            if item and item.ItemId and item.ItemId > 0 then
                local row = itemSheet:GetRow(item.ItemId)
                if row and row.ItemUICategory and (row.ItemUICategory.Row == CardUICategory or row.ItemUICategory.RowId == CardUICategory) then
                    total = total + (item.Count or 1)
                end
            end
        end
    end
    return total
end
yield("/echo Cards in bags: " .. tostring(GetCardCount()))


if MGP and Inventory.GetItemCount(29) >= MGP then
    yield("/echo <se.11> <se.11> <se.11> <se.11> <se.11>")
    yield("/echo Dummy, you already got "..Inventory.GetItemCount(29).." MGP. Set the script properly.")
    return
end

if Cards and GetCardCount() >= Cards then
    yield("/echo <se.11> <se.11> <se.11> <se.11> <se.11>")
    yield("/echo Dummy, you already got "..tostring(GetCardCount()).." cards. Set the script properly.")
    return
end

if tostring(Svc.ClientState.TerritoryType) ~= "156" then
    yield("/li tp Revenant's Toll")
    yield("/wait 6")
        if Addons.GetAddon("NowLoading").Ready then
            while Addons.GetAddon("NowLoading").Ready do
                yield("/wait 1")
            end
        end
end

for p in luanet.each(Svc.PluginInterface.InstalledPlugins) do
    if p.InternalName == "Saucy" and not p.IsLoaded then
        Engines.Native.Run("/xlenableplugin Saucy")
        break
    end
end

if not Svc.Condition[4] then
    yield("/ac Mount Roulette")
    yield("/wait 2")
end
    yield("/vnav flyto 449.8 -12.2 -386.2") 
while IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() do
    yield ("/wait 0.1")
end
    yield("/ac Dismount")
    yield("/target Klynthota")
    yield("/wait 1")
    yield("/interact")
        repeat
            yield("/wait 0.1")
        until Addons.GetAddon("TripleTriadRequest").Ready
    yield("/wait 0.5")
    yield("/saucy tt go")


if MGP or Cards then
    while true do
        if MGP and Inventory.GetItemCount(29) >= MGP then
            break
        end
            if MatchFinished then
                MatchFinished = false
                if Cards then
                    local currentCards = GetCardCount()
--                    yield("/echo Cards in bags: " .. tostring(currentCards))
                    if currentCards >= Cards then
                        break
                    end
                end
            end
        yield("/wait 0.5")
    end
end

while true do
    if Addons.GetAddon("TripleTriadRequest").Ready then
        yield("/callback TripleTriadRequest true -1")
        break
    elseif Addons.GetAddon("TripleTriadResult").Ready then
        yield("/callback TripleTriadResult true -1")
        break
    end
    yield("/wait 0.2")
end

yield("/saucy tt stop")
yield("/wait 2")

if tostring(Svc.ClientState.TerritoryType) ~= "144" then
    yield("/li tp Gold Saucer")
    yield("/wait 6")
    if Addons.GetAddon("NowLoading").Ready then
        while Addons.GetAddon("NowLoading").Ready do
            yield("/wait 1")
        end
    end
end

yield("/vnav moveto -55.6 1.6 16.2")
    while IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() do
        yield ("/wait 0.1")
    end
yield("/target Triple Triad Trader")
yield("/wait 1")
yield("/interact")
yield("/waitaddon SelectIconString")
yield("/callback SelectIconString true 1")
    repeat
        yield("/wait 0.1")
    until Addons.GetAddon("TripleTriadCoinExchange").Ready
yield("/wait 0.5")

--yield("/echo Cards in bags: " .. tostring(GetCardCount()))

while GetCardCount() > 0 do
    yield("/wait 1")
    yield("/callback TripleTriadCoinExchange true 0")
    yield("/wait 1")
end
--^ IF GAME CRASHES WHEN SELLING CARDS, INCREASE BOTH /wait HERE FROM1 1 TO 1.5 OR MORE ^


if GetCardCount() == 0 then
    yield("/callback TripleTriadCoinExchange true -1")
end

yield("/echo <se.7>")
yield("/e You cards have been farmed, my liege!")
