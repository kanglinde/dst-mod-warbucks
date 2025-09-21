AddAction("LOADBLUNDERBUSS", STRINGS.ACTIONS.LOADBLUNDERBUSS, function(act)
    local gun = act.target
    gun.OnAmmo(gun, true)
    gun.SoundEmitter:PlaySound("dontstarve_DLC003/common/items/weapon/blunderbuss_load")

    local ammo = act.invobject
    if ammo.components.stackable then ammo = ammo.components.stackable:Get() end
    ammo:Remove()
    
    return true
end)
ACTIONS.LOADBLUNDERBUSS.mount_valid = true

AddComponentAction("USEITEM", "explosive", function(inst, doer, target, actions, right)
    if target:HasTag("blunderbuss") and not target:HasTag("rangedweapon") and inst.prefab == "gunpowder" and 
        target.replica.equippable and target.replica.equippable:IsEquipped() then
        table.insert(actions, ACTIONS.LOADBLUNDERBUSS)
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.LOADBLUNDERBUSS, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.LOADBLUNDERBUSS, "give"))

AddStategraphPostInit("wilson", function(inst)
	local old_attack = inst.actionhandlers[ACTIONS.ATTACK].deststate
	inst.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action, ...)
		if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.components.health:IsDead()) then
			local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
			if weapon and weapon:HasTag("blunderbuss") and weapon:HasTag("rangedweapon") then
				return "blunderbuss"
			end
		end
		return old_attack(inst, action, ...)
	end
end)

AddStategraphPostInit("wilson_client", function(inst)
	local old_attack = inst.actionhandlers[ACTIONS.ATTACK].deststate
	inst.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action, ...)
		if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or IsEntityDead(inst)) then
			local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if equip and equip:HasTag("blunderbuss") and equip:HasTag("rangedweapon") then
				return "blunderbuss"
			end
		end
		return old_attack(inst, action, ...)
	end
end)