<cfif arguments.autoFix>
	<cfset arguments.value = reReplace( arguments.value, "[^[:print:]]", "", "all" )>
</cfif>

<cfif reFind( "[^[:print:]]", arguments.value )>
	<cfif attributes.mutable AND NOT attributes.autoFix>
		<cfset arguments.value = reReplace( arguments.value, "[^[:print:]]", "", "all" )>
	</cfif>
	<cfset arguments.message = "can only contain normal printable characters">
</cfif>

