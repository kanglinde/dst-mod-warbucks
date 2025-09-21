local assets = {
    Asset("ANIM", "anim/blunderbuss.zip"),
    Asset("ANIM", "anim/swap_blunderbuss.zip"),
    Asset("ANIM", "anim/swap_blunderbuss_loaded.zip"),

    Asset("ATLAS", "images/inventoryimages/blunderbuss.xml"),
    Asset("IMAGE", "images/inventoryimages/blunderbuss.tex"),
    Asset("ATLAS", "images/inventoryimages/blunderbuss_loaded.xml"),
    Asset("IMAGE", "images/inventoryimages/blunderbuss_loaded.tex"),
}

local projectile_assets = {
    Asset("ANIM", "anim/blunderbuss_ammo.zip"),
}

local cloudpuff_assets = {
    Asset("ANIM", "anim/cloud_puff_soft.zip"),
}

RegisterInventoryItemAtlas("images/inventoryimages/blunderbuss.xml", "blunderbuss.tex")

------------------------------------------- blunderbuss -------------------------------------------

local RAW_DMG = 15
local AMMO_DMG = TUNING.GUNPOWDER_DAMAGE

local function onattack(inst, attacker, target)
    if inst:HasTag("rangedweapon") then
        inst.OnAmmo(inst, false)
        inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/items/weapon/blunderbuss_shoot")
    end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", inst.override_bank, "swap_blunderbuss")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onsave(inst, data)
    if inst:HasTag("rangedweapon") then data.isloaded = true end
end

local function onload(inst, data)
    if data and data.isloaded then inst.OnAmmo(inst, true) end
end

local function onammo(inst, loaded)
    if loaded then
        inst:AddTag("rangedweapon")

        local mode = "blunderbuss_loaded"
        inst.override_bank = "swap_"..mode
        if inst.components.equippable and inst.components.equippable:IsEquipped() then
            inst.components.inventoryitem.owner.AnimState:OverrideSymbol("swap_object", inst.override_bank, "swap_blunderbuss")
        end
        inst.components.inventoryitem.atlasname = "images/inventoryimages/"..mode..".xml"
        inst.components.inventoryitem:ChangeImageName(mode)

        inst.components.weapon:SetDamage(AMMO_DMG)
        inst.components.weapon:SetRange(10)
        inst.components.weapon:SetProjectile("gunpowder_projectile")
    else
        inst:RemoveTag("rangedweapon")

        local mode = "blunderbuss"
        inst.override_bank = "swap_"..mode
        if inst.components.equippable and inst.components.equippable:IsEquipped() then
            inst.components.inventoryitem.owner.AnimState:OverrideSymbol("swap_object", inst.override_bank, "swap_blunderbuss")
        end
        inst.components.inventoryitem.atlasname = "images/inventoryimages/"..mode..".xml"
        inst.components.inventoryitem:ChangeImageName(mode)

        inst.components.weapon:SetDamage(RAW_DMG)
        inst.components.weapon:SetRange(nil)
        inst.components.weapon:SetProjectile(nil)
    end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med")

    inst.AnimState:SetBank("blunderbuss")
    inst.AnimState:SetBuild("blunderbuss")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("blunderbuss")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/blunderbuss.xml"
    inst.components.inventoryitem.imagename = "blunderbuss"

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(RAW_DMG)
    inst.components.weapon:SetOnAttack(onattack)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst.override_bank = "swap_blunderbuss"

    inst.OnSave = onsave
    inst.OnLoad = onload

    inst.OnAmmo = onammo

    MakeHauntableLaunch(inst)

    return inst
end

------------------------------------------- gunpowder ammo -------------------------------------------

local function onhit(inst, owner, target)
    if target ~= nil and target:IsValid() and target.components.combat then
        local impactfx = SpawnPrefab("impact")
        if impactfx ~= nil then
            local follower = impactfx.entity:AddFollower()
            follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0)
            impactfx:FacePoint(inst.Transform:GetWorldPosition())
        end
    end
    inst:Remove()
end

local function projectile_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeProjectilePhysics(inst)

    inst.AnimState:SetBank("amo01")
    inst.AnimState:SetBuild("blunderbuss_ammo")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("projectile")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(60) -- shouldn't be slower than blow dart...
    inst.components.projectile:SetOnHitFn(onhit)

    inst.persists = false

    return inst
end

------------------------------------------- cloudpuff -------------------------------------------

local function cloudpuff_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("cloud_puff_soft")
    inst.AnimState:SetBank("splash_clouds_drop")
    inst.AnimState:PlayAnimation("idle_sink")

    inst:AddTag("FX" )
    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.OnEntitySleep = inst.Remove
    inst:ListenForEvent("animover", inst.Remove)

    inst.persists = false

    return inst
end

return Prefab("blunderbuss", fn, assets),
       Prefab("gunpowder_projectile", projectile_fn, projectile_assets),
       Prefab("cloudpuff", cloudpuff_fn, cloudpuff_assets)