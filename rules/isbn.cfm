<cfif arguments.autoFix>
	<cfset arguments.value = left( reReplace( arguments.value, "[^0-9X]", "", "all" ), 13 )>
</cfif>

<cfif NOT reFind( "^[0-9]{9,12}[0-9X]?$", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = left( reReplace( arguments.value, "[^0-9X]", "", "all" ), 13 )>
	</cfif>
	<cfset arguments.message = "is not a valid ISBN code">
<cfelse>
	<cfset loc.total = 0>
	<cfset loc.test = 0>
	<cfset loc.checkDigit = 0>
	<cfset loc.i = 1>
	<cfset loc.test = left( arguments.value, len( arguments.value ) - 1 )>
	<cfset loc.checkDigit = right( arguments.value, 1 )>
	<cfloop index="loc.i" from="1" to="#len( loc.test )#">
		<cfset loc.total = loc.total + (mid( arguments.value, loc.i, 1 ) * loc.i)>
	</cfloop>
	<cfset loc.test = loc.total mod 11>
	<cfif loc.test IS 10>
		<cfset loc.test = "X">
	</cfif>
	<cfif loc.test IS NOT loc.checkDigit>
		<cfset arguments.message = "is not a valid ISBN code">
	</cfif>
</cfif>