<cfif arguments.autoFix>
	<cfset arguments.value = left( reReplace( arguments.value, "[^0-9]", "", "all" ), 13 )>
</cfif>

<cfif NOT reFind( "^[0-9]{13}$", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = left( reReplace( arguments.value, "[^0-9]", "", "all" ), 13 )>
	</cfif>
	<cfset arguments.message = "is not a valid EAN code">
</cfif>
