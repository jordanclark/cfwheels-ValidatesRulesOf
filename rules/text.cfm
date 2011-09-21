<cfif arguments.autoFix>
	<cfset arguments.value = reReplace( arguments.value, "[^[:print:]]", "", "all" )>
</cfif>

<cfif reFind( "[^[:print:]]", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = reReplace( arguments.value, "[^[:print:]]", "", "all" )>
	</cfif>
	<cfset arguments.message = "can only contain normal printable characters">
</cfif>

