_addon = {'Stubborn'}
_addon.name = 'Randy'
_addon.command = 'stubborn'
_addon.author = 'Arico'

require 'pack'
require 'strings'
require('logger')
packets = require('packets')

------------------------------------
-- Called on an outgoing packet-----
------------------------------------
windower.register_event('outgoing chunk', function(id,original,modified,injected,blocked)
	if id == 0x01a then
		local p = packets.parse('outgoing',original)
		if p['Category'] == 5 and not injected then
			log("Yayaya I am Lorde yayaya (Call for help is blocked)")
			return true
		end
	end
end)


------------------------------------
-- Called when //stubborn is typed--
------------------------------------

windower.register_event('addon command', function(...)
    local args = T{...}
    local cmd = args[1]
	local npc_index = windower.ffxi.get_mob_by_target("t")['index']
	local npc_id = windower.ffxi.get_mob_by_target("t")['id']
	 local p = packets.new('outgoing', 0x1a,{
            ['Target'] = npc_id,
            ['Target Index'] = npc_index,
            ['Category'] = 5,
        })
        packets.inject(p)
	
	
end)
