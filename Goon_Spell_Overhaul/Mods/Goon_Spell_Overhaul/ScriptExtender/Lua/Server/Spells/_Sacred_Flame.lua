-- Helper function to handle spell on ground targeting
function OnUsingSpellAtPosition(casterGuid, x, y, z, spell)
    -- Print debug info to track if the listener is being triggered
    
    -- Ext.Utils.Print("[DEBUG] UsingSpellAtPosition triggered: Spell = " .. tostring(spell))
    -- Ext.Utils.Print("[DEBUG] Caster GUID: " .. tostring(casterGuid))
    -- Ext.Utils.Print("[DEBUG] Position: X = " .. tostring(x) .. ", Y = " .. tostring(y) .. ", Z = " .. tostring(z))

    -- Check if the spell matches Sacred Flame
    if string.match(spell, "Target_SacredFlame") then
        -- Parameters for surface creation
        local surfaceType = "SurfaceHolyFire"
        local radius = 1
        local lifetime = 18

        -- Debug check for parameter values
        if type(radius) ~= "number" or type(lifetime) ~= "number" then
            -- Ext.Utils.Print("[ERROR] Invalid parameter types for CreateSurfaceAtPosition!")
            return
        end

        -- Create the surface at the targeted position with the specified radius and lifetime
        Osi.CreateSurfaceAtPosition(x, y, z, surfaceType, radius, lifetime)
        -- Ext.Utils.Print("[DEBUG] Created SurfaceHolyFire at position!")
    end
end

-- Register the event listener
Ext.Osiris.RegisterListener("UsingSpellAtPosition", 8, "before", function(casterGuid, x, y, z, spell, spellType, spellElement, story)
    OnUsingSpellAtPosition(casterGuid, x, y, z, spell)
end)
