local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

local skin_assets = {
    Asset("ANIM", "anim/warbucks.zip"),
    Asset("ANIM", "anim/ghost_warbucks_build.zip"),
}

local skin_warbucks_none = {
    base_prefab = "warbucks",
    type = "base",
    assets = skin_assets,
    skins = {normal_skin = "warbucks", ghost_skin = "ghost_warbucks_build"}, 
    skin_tags = {"WARBUCKS", "CHARACTER", "BASE"},
    build_name = "warbucks",
    rarity = "Character",
}

local prefabs = {
    "pithhat",
    "blunderbuss",
    "gunpowder",
}

local function sanityfn(inst)
    local delta = 0

    local gold = inst.components.inventory:FindItems(function(item) return item.prefab == "goldnugget" end)
    local gold_amount = 0
    for _,v in ipairs(gold) do
        gold_amount = gold_amount + (v.components.stackable and v.components.stackable:StackSize() or 1)
    end

    if gold_amount >= 140 then
        delta = TUNING.SANITYAURA_SMALL
    elseif gold_amount >= 60 then
        delta = TUNING.SANITYAURA_SMALL_TINY
    elseif gold_amount >= 20 then
        delta = TUNING.SANITYAURA_TINY
    end

    return delta
end

local function oneat(inst, data)
    local food = data.food
    local iscooked = food:HasTag("preparedfood") or food.AnimState:IsCurrentAnimation("cooked")
    local isdried = food.AnimState:GetBuild() == "meat_rack_food" or food.AnimState:GetBuild() == "meat_rack_food_tot"
    local isgoodie = food.components.edible.foodtype == FOODTYPE.GOODIES or food.components.edible.secondaryfoodtype == FOODTYPE.GOODIES

    if not (iscooked or isdried or isgoodie) then
        local speech = math.random() > 0.45 and "SPOILED" or "PAINFUL"
        inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_EAT", speech))
        inst.components.sanity:DoDelta(-TUNING.SANITY_SMALL)
    end
end

local function common_postinit(inst)
    inst.MiniMapEntity:SetIcon("warbucks.tex")
    inst:AddTag("warbucks")
end

local function master_postinit(inst)
    inst.starting_inventory = TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WARBUCKS

    inst.soundsname = "warbucks"
    inst.talker_path_override = "dontstarve_DLC003/characters/"

    inst.components.health:SetMaxHealth(TUNING.WARBUCKS_HEALTH)
    inst.components.hunger:SetMax(TUNING.WARBUCKS_HUNGER)
    inst.components.sanity:SetMax(TUNING.WARBUCKS_SANITY)
    inst.components.sanity.custom_rate_fn = sanityfn

    inst:ListenForEvent("oneat", oneat)
end

return MakePlayerCharacter("warbucks", prefabs, assets, common_postinit, master_postinit),
       CreatePrefabSkin("warbucks_none", skin_warbucks_none)