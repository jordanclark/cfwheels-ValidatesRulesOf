<cfif arguments.autoFix>
	<cfset arguments.value = left( reReplace( arguments.value, "[^0-9]", "", "all" ), 12 )>
</cfif>

<cfif NOT reFind( "^[0-9]{12}$", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = left( trim( reReplace( arguments.value, "[^0-9]", "", "all" ) ), 12 )>
	</cfif>
	<cfset arguments.message = "is not a valid UPC code">
<cfelse>
	<cfset loc.odd = 0>
	<cfset loc.even = 0>
	<cfset loc.total = 0>
	<cfloop index="loc.i" from="1" to="11">
		<cfif loc.i MOD 2>
			<cfset loc.odd = loc.odd + mid( arguments.value, loc.i, 1 )>
		<cfelse>
			<cfset loc.even = loc.even + mid( arguments.value, loc.i, 1 )>
		</cfif>
	</cfloop>
	<cfset loc.total = (loc.odd * 3) + loc.even>
	<cfset loc.total = loc.total MOD 10>
	<cfif loc.total IS 0>
		<cfset loc.checkDigit = 0>
	<cfelse>
		<cfset loc.checkDigit = 10 - loc.total>
	</cfif>
	<cfif right( arguments.value, 1 ) IS NOT loc.checkDigit>
		<cfset arguments.message = "is not a valid UPC code">
	</cfif>
</cfif>
