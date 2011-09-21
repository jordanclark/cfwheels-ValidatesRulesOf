<cfif arguments.autoFix>
	<cfset arguments.value = reReplace( arguments.value, "[^[:digit:]]", "", "all" )>
</cfif>

<cfif NOT isNumeric( arguments.value ) OR reFindNoCase( "[^[:digit:]]", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = reReplace( arguments.value, "[^[:digit:]]", "", "all" )>
	</cfif>
	<cfset arguments.message = "can only contain numbers (0-9)">
</cfif>
