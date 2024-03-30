
---@param e ModCheckHitChance
function CheckHitChance(e)

    local multiplier = 1

    local is_good = false
    local ally = e.self
    local enemy = e.other
    if not ally.valid then
        return e
    end
    if not enemy.valid then
        return e
    end
    if not ally:IsClient() then
        if ally:HasOwner() and ally:GetOwner():IsClient() then
            ally = ally:GetOwner() -- pet
        else
            is_good = true
            ally = e.other
            enemy = e.self
            if not ally:IsClient() then
                if not ally:HasOwner() then
                    return e
                end
                if not ally:GetOwner():IsClient() then
                    return e
                end
                ally = ally:GetOwner() -- pet
            end
        end
    end

    if not enemy:IsNPC() then
        return e
    end

    local mighty = ally:GetBucket("boost_mighty")
    if mighty == "ON" then
        if is_good then
            multiplier = 2
        else
            multiplier = 0.5
        end
    end

    local is_debug = ally:GetBucket("mighty_debug")

    e.hit.tohit = e.hit.tohit * multiplier
    e.hit.base_damage = e.hit.base_damage * multiplier
    e.hit.damage_done = e.hit.damage_done * multiplier
    if e.hit.damage_done < 1 then
        e.hit.damage_done = 1
    end

    if not is_debug or is_debug ~= "ON" then
        return e
    end

    if is_good then
        ally:Message(MT.YouHitOther, string.format("outgoing base_hit: %d, base_dmg: %d, base_dmg_done: %d, multiplier: %d, hit: %d, dmg: %d, dmg_done: %d", e.hit.tohit /multiplier, e.hit.base_damage/multiplier, e.hit.damage_done/multiplier, multiplier, e.hit.tohit, e.hit.base_damage, e.hit.damage_done))
        return e
    end
    ally:Message(MT.OtherHitsYou, string.format("incoming base_hit: %d, base_dmg: %d, base_dmg_done: %d, multiplier: %f, hit: %d, dmg: %d, dmg_done: %d", e.hit.tohit/multiplier, e.hit.base_damage/multiplier, e.hit.damage_done/multiplier, multiplier, e.hit.tohit, e.hit.base_damage, e.hit.damage_done))
    return e
end
