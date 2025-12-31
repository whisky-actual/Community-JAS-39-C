local ES = GetSelf()



function post_initialize()
	ES:AC_Generator_1_on(true)
	ES:AC_Generator_2_on(true)
	ES:DC_Battery_on(true)
end